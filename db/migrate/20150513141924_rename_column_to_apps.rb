class RenameColumnToApps < ActiveRecord::Migration

  # 変更後
  def up
    # メソッド :テーブル名, :旧名, :新名
    rename_column :apps, :alias, :app_name
  end

  # 変更前
  def down
    # メソッド :テーブル名, :新名, :旧名
    rename_column :apps, :app_name, :alias
  end
end
