class CreateCreditCards < ActiveRecord::Migration[7.0]
  def change
    create_table :credit_cards do |t|
      t.string :email
      t.string :card_number
      t.string :expiry_date
      t.string :cvv

      t.timestamps
    end
  end
end
