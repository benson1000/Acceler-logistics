class AddServiceToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :services, :text
  end
end
