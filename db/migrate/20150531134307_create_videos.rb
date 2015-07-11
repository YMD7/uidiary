class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :version_id
      t.integer :video_id
      t.string :video_type
      t.string :video_title
      t.string :video_location
    end
  end
end
