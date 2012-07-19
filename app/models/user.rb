class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :last_name, :first_name, :t_number

  # Validations
  validates_uniqueness_of :email, :t_number
  validates_presence_of :email, :last_name, :first_name, :t_number

end
