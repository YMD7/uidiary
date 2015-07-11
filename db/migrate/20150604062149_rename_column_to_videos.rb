class RenameColumnToVideos < ActiveRecord::Migration
  def change
    rename_column :videos, :video_type, :type
    rename_column :videos, :video_title, :title
  end
end
