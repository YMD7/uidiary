class RenameSourceToVideoSources < ActiveRecord::Migration
  def change
    rename_column :video_sources, :source, :file
  end
end
