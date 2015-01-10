class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.text :description
      t.string :status
      t.integer :owner
      t.integer :stuff

      t.timestamps null: false
    end
  end
end
