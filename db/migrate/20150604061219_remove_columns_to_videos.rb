class RemoveColumnsToVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :video_id, :string
    remove_column :videos, :video_location, :string
  end
end
