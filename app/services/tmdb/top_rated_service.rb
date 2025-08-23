require 'uri'
require 'net/http'
require 'json'

class Tmdb::TopRatedService
  TMDB_API_URL = 'https://api.themoviedb.org/3/movie/top_rated'

  def initialize(language: 'en-US', page: 1)
    @language = language
    @page = page
    @bearer_token = ENV.fetch('TMDB_BEARER_TOKEN')
  end

  def fetch
    url = URI("#{TMDB_API_URL}?language=#{@language}&page=#{@page}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request['accept'] = 'application/json'
    request['Authorization'] = "Bearer #{@bearer_token}"

    response = http.request(request)
    JSON.parse(response.read_body)['results']
  rescue => e
    Rails.logger.error "TMDb API error: #{e.message}"
    []
  end
end
