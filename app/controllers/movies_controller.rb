class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    @movies = Tmdb::TopRatedMoviesService.new(language: 'en-US').fetch
    @movie_banner = Movie.all.sample
  end

  def show
    @movie_banner = Movie.find_by(tmdb_id: params[:id]) # ne lève plus d'erreur ici

    @movie = Tmdb::MovieDetailsService.new(id: params[:id], language: 'en-US').fetch

    unless @movie
      redirect_to movies_path, alert: 'Film introuvable.'
      return
    end

    @bookmark = Bookmark.new
  end

end
