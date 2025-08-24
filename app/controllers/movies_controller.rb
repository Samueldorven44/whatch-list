class MoviesController < ApplicationController

  def index
    @movies = Tmdb::TopRatedService.new(language: 'fr-FR').fetch
  end

  def show
    @movie = Tmdb::MovieDetailsService.new(id: params[:id], language: 'fr-FR').fetch
    redirect_to movies_path, alert: 'Film introuvable.' unless @movie
  end

end
