class AddColumnsMiniDescriptionToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :mini_description, :string
  end
end
