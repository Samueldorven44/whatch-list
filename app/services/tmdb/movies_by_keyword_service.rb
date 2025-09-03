require 'uri'
require 'net/http'
require 'json'

module Tmdb
  class MoviesByKeywordService
    BASE_URL = 'https://api.themoviedb.org/3/discover/movie'

    def initialize(keyword_id, language: 'en-US', pages: 1)
      @keyword_id = keyword_id
      @language = language
      @pages = pages
      @bearer_token = ENV.fetch('TMDB_BEARER_TOKEN')
    end

    def fetch
      all_results = []

      (1..@pages).each do |page|
        url = URI("#{BASE_URL}?language=#{@language}&with_keywords=#{@keyword_id}&page=#{page}")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(url)
        request['accept'] = 'application/json'
        request['Authorization'] = "Bearer #{@bearer_token}"

        response = http.request(request)
        result = JSON.parse(response.read_body)
        all_results.concat(result['results']) if result['results']
      rescue => e
        Rails.logger.error "Erreur recherche de films TMDB : #{e.message}"
      end

      all_results
    end
  end
end
