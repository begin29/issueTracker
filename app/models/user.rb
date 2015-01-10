class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tickets

  private
    def password_required?
      user_type == 'customer' ? false : !persisted? || !password.nil? || !password_confirmation.nil?
    end
end
