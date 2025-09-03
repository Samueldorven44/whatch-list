class ExplorerController < ApplicationController

  def index
    query = params.dig(:search, :query)

    if query.present?
      movies = Tmdb::SearchMoviesByKeywordService.new(query, language: 'fr-FR', pages: 2).fetch
    else
      movies = Tmdb::TopRatedService.new(language: 'fr-FR').fetch
    end

    @movies = Kaminari.paginate_array(movies).page(params[:page]).per(12)
  end
end
