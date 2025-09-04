module Tmdb
  class TopRatedMoviesService < BaseService
    BASE_URL = 'https://api.themoviedb.org/3/movie/top_rated'

    def initialize(language: 'en-US', pages: 10)
      @language = language
      @pages = pages
    end

    def fetch
      (1..@pages).flat_map do |page|
        url = "#{BASE_URL}?language=#{@language}&page=#{page}"
        result = get_json(url)
        result['results'] if result
      end.compact.flatten
    end
  end
end
