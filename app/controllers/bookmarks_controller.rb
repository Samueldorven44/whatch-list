class BookmarksController < ApplicationController
  before_action :set_bookmark, only: :destroy

  def create
    movie = Movie.find_or_create_by(tmdb_id: params[:tmdb_id]) do |m|
      m.name = params[:title]
      m.poster_url = params[:poster_path]
    end

    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.movie = movie

    if @bookmark.save
      redirect_to list_path(@bookmark.list), notice: "Film ajouté à la liste ✅"
    else
      redirect_back fallback_location: root_path, alert: "Erreur lors de l'ajout ❌"
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:list_id, :name, :comment, :rating)
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

end
