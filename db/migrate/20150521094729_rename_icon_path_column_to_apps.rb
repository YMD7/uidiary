class RenameIconPathColumnToApps < ActiveRecord::Migration
  def change
    rename_column :Apps, :icon_path, :icon_filename
  end
end
