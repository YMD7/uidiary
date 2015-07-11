class AddAppDeveloperToApps < ActiveRecord::Migration
  def change
    add_column :apps, :app_developer, :string
  end
end
