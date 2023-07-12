class AddStatusToOrders < ActiveRecord::Migration[7.0]
  def change
    def up
      execute <<-SQL
        CREATE TYPE status_enum AS ENUM (
          'ready_for_dispatch',
          'partially_dispatched',
          'dispatched',
          'delivered'
        );
      SQL
      add_column :orders, :status, :string, default: 'ready_for_dispatch'
    end

    def down
      remove_column :orders, :status
      execute <<-SQL
        DROP TYPE status_enum;
      SQL
    end

  end
end
