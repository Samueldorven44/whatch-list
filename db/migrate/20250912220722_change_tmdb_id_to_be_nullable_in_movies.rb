class ChangeTmdbIdToBeNullableInMovies < ActiveRecord::Migration[7.1]
  def change
    change_column_null :movies, :tmdb_id, true
  end
end
