class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :own_tickets, class_name: 'Ticket', foreign_key: :stuff_id

  has_many :ticket_logs
  has_many :created_tickets, through: :ticket_logs

  after_create do
    Sunspot.index! self
  end

  searchable do
    text :email, :first_name, :last_name
  end

  def self.new_guest
    new { |u| u.guest = true }
  end

  def full_name
    self.guest? ? "Guest" : "#{first_name} #{last_name}"
  end

  private
    def password_required?
      !self.guest?
    end
end
