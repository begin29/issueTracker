class AddCustomerIdToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :customer_id, :integer
  end
end
