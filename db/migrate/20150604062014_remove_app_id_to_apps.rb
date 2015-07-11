class RemoveAppIdToApps < ActiveRecord::Migration
  def change
    remove_column :apps, :app_id
  end
end
