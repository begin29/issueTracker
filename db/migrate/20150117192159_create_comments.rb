class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :ticket_id
      t.text :message

      t.timestamps null: false
    end
  end
end
