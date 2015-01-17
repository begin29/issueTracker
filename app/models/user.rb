class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tickets

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
