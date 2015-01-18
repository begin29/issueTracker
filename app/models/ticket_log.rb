class TicketLog < ActiveRecord::Base
  belongs_to :created_ticket, class_name: 'Ticket', foreign_key: :ticket_id
  belongs_to :customer
end
