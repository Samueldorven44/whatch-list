require 'uri'
require 'net/http'
require 'json'

class Tmdb::MovieDetailsService
  TMDB_API_URL = 'https://api.themoviedb.org/3/movie'

  def initialize(id:, language: 'en-US')
    @id = id
    @language = language
    @bearer_token = ENV.fetch('TMDB_BEARER_TOKEN')
  end

  def fetch
    url = URI("#{TMDB_API_URL}/#{@id}?language=#{@language}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request['accept'] = 'application/json'
    request['Authorization'] = "Bearer #{@bearer_token}"

    response = http.request(request)
    JSON.parse(response.read_body)
  rescue => e
    Rails.logger.error "TMDb API error: #{e.message}"
    nil
  end
end
