class RenameVersionToApps < ActiveRecord::Migration
  def change
    rename_column :apps, :version, :current_version
  end
end
