require 'uri'
require 'net/http'
require 'json'

class Tmdb::TopRatedService
  TMDB_API_URL = 'https://api.themoviedb.org/3/movie/top_rated'

  def initialize(language: 'en-US', pages: 10)
    @language = language
    @pages = pages
    @bearer_token = ENV.fetch('TMDB_BEARER_TOKEN')
  end

  def fetch
    all_results = []

    (1..@pages).each do |page|
      url = URI("#{TMDB_API_URL}?language=#{@language}&page=#{page}")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request['accept'] = 'application/json'
      request['Authorization'] = "Bearer #{@bearer_token}"

      response = http.request(request)
      results = JSON.parse(response.read_body)['results']
      all_results.concat(results) if results
    rescue => e
      Rails.logger.error "TMDb API error (page #{page}): #{e.message}"
    end

    all_results
  end
end
