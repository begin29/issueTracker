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

  def full_name
    "#{first_name} #{last_name}"
  end

  def stuff_type?
    user_type == 'stuff'
  end

  private
    def password_required?
      user_type == 'customer' ? false : !persisted? || !password.nil? || !password_confirmation.nil?
    end
end
