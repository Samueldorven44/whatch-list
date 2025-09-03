require 'uri'
require 'net/http'
require 'json'

module Tmdb
  class KeywordSearchService
    BASE_URL = 'https://api.themoviedb.org/3/search/keyword'

    def initialize(keyword)
      @keyword = keyword
      @bearer_token = ENV.fetch('TMDB_BEARER_TOKEN')
    end

    def fetch_id
      url = URI("#{BASE_URL}?query=#{URI.encode_www_form_component(@keyword)}&page=1")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request['accept'] = 'application/json'
      request['Authorization'] = "Bearer #{@bearer_token}"

      response = http.request(request)
      result = JSON.parse(response.read_body)

      puts JSON.pretty_generate(result)

      return result['results'].first['id'] if result['results']&.any?

      nil
    rescue => e
      Rails.logger.error "Erreur recherche mot-clé TMDB : #{e.message}"
      nil
    end
  end
end
