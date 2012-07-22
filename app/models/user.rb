class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :last_name, :first_name, :t_number

  # Validations
  validates_presence_of :last_name, :first_name, :t_number
  # devise validates_presence_of :email
  validates_uniqueness_of :email, :t_number
  # gem 'validates_email_format_of'
  validates_email_format_of :email
  validate :format_of_t_number

  T_NUMBER_FORMAT = /T\d{8}/
  def format_of_t_number
#   errors.add(:t_number, "is not valid (note that it must include the 'T')") unless self.t_number =~ T_NUMBER_FORMAT
  end
end
