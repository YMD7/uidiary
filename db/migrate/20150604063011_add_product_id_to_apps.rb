class AddProductIdToApps < ActiveRecord::Migration
  def change
    add_column :apps, :product_id, :integer
  end
end
