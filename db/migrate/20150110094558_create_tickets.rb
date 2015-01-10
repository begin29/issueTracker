class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.text :description
      t.string :status
      t.integer :customer_id
      t.integer :stuff_id
      t.string :subject

      t.timestamps null: false
    end
  end
end
