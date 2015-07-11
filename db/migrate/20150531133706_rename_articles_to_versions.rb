class RenameArticlesToVersions < ActiveRecord::Migration
  def change
    rename_table :articles, :versions
  end
end
