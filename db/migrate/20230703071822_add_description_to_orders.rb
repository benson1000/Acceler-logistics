class AddDescriptionToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :description, :text
  end
end
