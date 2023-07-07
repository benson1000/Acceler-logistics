class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :sender_name
      t.string :sender_phone
      t.string :sender_email
      t.string :source_location
      t.string :recipient_name
      t.string :recipient_phone
      t.string :recipient_email
      t.string :destination_location
      t.timestamps
    end

    create_table :order_services do |t|
      t.belongs_to :order
      t.string :service

      t.timestamps
    end
  end
end
