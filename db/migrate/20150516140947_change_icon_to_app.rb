class ChangeIconToApp < ActiveRecord::Migration
  def change
    change_column :Apps, :icon, :string
    rename_column :Apps, :icon, :icon_path
  end
end
