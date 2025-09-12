class Movie < ApplicationRecord
  has_many :bookmarks

  def to_param
    tmdb_id.to_s
  end

end
