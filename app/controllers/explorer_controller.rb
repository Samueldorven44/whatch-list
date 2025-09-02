class ExplorerController < ApplicationController

  def index
    movies = Tmdb::TopRatedService.new(language: 'fr-FR').fetch
    @movies = Kaminari.paginate_array(movies).page(params[:page]).per(12)
  end

end
