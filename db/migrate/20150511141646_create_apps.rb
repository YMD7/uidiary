class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.integer :app_id
      t.string  :alias
      t.string  :genre

      t.timestamps
    end
  end
end
