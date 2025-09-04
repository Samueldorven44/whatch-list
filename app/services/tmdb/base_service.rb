require 'uri'
require 'net/http'
require 'json'

module Tmdb
  class BaseService
    private

    def bearer_token
      ENV.fetch('TMDB_BEARER_TOKEN')
    end

    def get_json(url)
      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri)
      request['accept'] = 'application/json'
      request['Authorization'] = "Bearer #{bearer_token}"

      response = http.request(request)
      JSON.parse(response.read_body)
    rescue => e
      Rails.logger.error "TMDb API error: #{e.message}"
      nil
    end
  end
end
