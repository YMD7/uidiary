class RenameTypeColumnToVideos < ActiveRecord::Migration
  def change
    rename_column :videos, :type, :typeof
  end
end
