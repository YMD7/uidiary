class RenameColumnsToApps < ActiveRecord::Migration
  def change
    rename_column :apps, :app_name, :name
    rename_column :apps, :app_developer, :developer
    rename_column :apps, :app_url, :url
  end
end
