require 'uri'
require 'net/http'
require 'json'

module Tmdb
  class MovieSearchService
    BASE_URL = 'https://api.themoviedb.org/3/search/movie'

    def initialize(title)
      @title = title
      @bearer_token = ENV.fetch('TMDB_BEARER_TOKEN')
    end

    def fetch
      url = URI("#{BASE_URL}?query=#{URI.encode_www_form_component(@title)}&page=1")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request['accept'] = 'application/json'
      request['Authorization'] = "Bearer #{@bearer_token}"

      response = http.request(request)
      result = JSON.parse(response.read_body)

      result['results'] || []
    rescue => e
      Rails.logger.error "Erreur recherche de film TMDB : #{e.message}"
      []
    end
  end
end
