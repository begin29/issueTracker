class CreateTicketLogs < ActiveRecord::Migration
  def change
    create_table :ticket_logs do |t|
      t.integer :user_id
      t.integer :ticket_id

      t.timestamps null: false
    end
  end
end
