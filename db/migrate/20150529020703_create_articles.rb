class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :app_id
      t.string  :version
      t.integer :movie_id
      t.string  :movie_type
      t.string  :movie_title
      t.string  :movie_location

      t.timestamps
    end
  end
end
