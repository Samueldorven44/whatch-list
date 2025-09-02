class BookmarksController < ApplicationController

  before_action :set_list, only: [:new]

  def new
    @bookmark = Bookmark.new
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

end
