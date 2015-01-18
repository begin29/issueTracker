class ChangeColumnFromUserIdToCustomerIdForTicketLogs < ActiveRecord::Migration
  def change
    remove_column :ticket_logs, :user_id
    add_column :ticket_logs, :customer_id, :integer
  end
end
