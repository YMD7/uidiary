class RemoveMovieColumnsToArticles < ActiveRecord::Migration
  def change
    remove_column :versions, :movie_id
    remove_column :versions, :movie_type
    remove_column :versions, :movie_title
    remove_column :versions, :movie_location
  end
end
