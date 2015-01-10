class AddSlugToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :slug, :string, uniq: true
  end
end
