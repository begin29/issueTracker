class Customer < User
  has_many :ticket_logs
  has_many :created_tickets, through: :ticket_logs

  # accepts_nested_attributes_for :created_tickets

  private
    def password_required?
      false
    end

end
