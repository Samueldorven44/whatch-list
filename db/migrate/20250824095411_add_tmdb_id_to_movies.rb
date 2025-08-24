class AddTmdbIdToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :tmdb_id, :integer, null: false
    add_index :movies, :tmdb_id, unique: true
  end
end
