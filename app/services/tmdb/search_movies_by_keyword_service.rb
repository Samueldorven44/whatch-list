module Tmdb
  class SearchMoviesByKeywordService
    def initialize(keyword, language: 'en-US', pages: 1)
      @keyword = keyword
      @language = language
      @pages = pages
    end

    def fetch
      keyword_id = Tmdb::KeywordSearchService.new(@keyword).fetch_id
      return [] unless keyword_id

      Tmdb::MoviesByKeywordService.new(keyword_id, language: @language, pages: @pages).fetch
    end
  end
end
