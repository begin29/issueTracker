class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  self.inheritance_column = :user_type

  has_many :own_tickets, class_name: 'Ticket', foreign_key: :stuff_id

  after_create do
    Sunspot.index! self
  end

  searchable do
    text :email, :first_name, :last_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
