class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :last_name, :first_name, :t_number

  has_and_belongs_to_many :excos_instructing, class_name: 'Exco', join_table: 'excos_instructors'
  attr_accessible :excos_instructing

  T_NUMBER_FORMAT = /T\d{8}/

  # Validations
  validates_presence_of :last_name, :first_name, :t_number
  # devise validates_presence_of :email
  validates_uniqueness_of :email, :t_number
  # gem 'validates_email_format_of'
  validates_email_format_of :email
  validates_format_of :t_number, :with => T_NUMBER_FORMAT

  def name
    name_first_last
  end

  def name_first_last
    "#{first_name} #{last_name}"
  end

  def name_last_first
    "#{last_name}, #{first_name}"
  end

  def admin?
    admin
  end

end
