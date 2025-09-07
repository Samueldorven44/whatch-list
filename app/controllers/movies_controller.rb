class MoviesController < ApplicationController

  def index
    @movies = Tmdb::TopRatedMoviesService.new(language: 'en-US').fetch
  end

  def show
    @movie = Tmdb::MovieDetailsService.new(id: params[:id], language: 'en-US').fetch
    redirect_to movies_path, alert: 'Film introuvable.' unless @movie
    @bookmark = Bookmark.new
  end

end
