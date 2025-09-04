class ExplorerController < ApplicationController

  def index
    query = params.dig(:search, :query)

    if query.present?
      movies = Tmdb::MovieSearchService.new(query).fetch
    else
      movies = Tmdb::TopRatedService.new(language: 'en-US').fetch
    end

    @movies = Kaminari.paginate_array(movies).page(params[:page]).per(12)
  end
end
