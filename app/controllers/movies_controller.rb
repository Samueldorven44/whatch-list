class MoviesController < ApplicationController
  def index
    @movies = Tmdb::TopRatedService.new(language: 'fr-FR').fetch
  end
end
