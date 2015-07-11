class AddColumnToApps < ActiveRecord::Migration
  def change
    add_column :apps, :version, :string
    add_column :apps, :icon, :binary
  end
end
