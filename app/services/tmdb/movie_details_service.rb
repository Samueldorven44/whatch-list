module Tmdb
  class MovieDetailsService < BaseService
    BASE_URL = 'https://api.themoviedb.org/3/movie'

    def initialize(id:, language: 'en-US')
      @id = id
      @language = language
    end

    def fetch
      url = "#{BASE_URL}/#{@id}?language=#{@language}"
      get_json(url)
    end
  end
end
