class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  #  devise :database_authenticatable, :registerable,
  #         :recoverable, :rememberable, :trackable, :validatable

  devise :database_authenticatable, :registerable, :recoverable

  
#  devise :database_authenticatable, :trackable, :timeoutable,
#         :timeout_in => 20.minutes

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  validate :email, :uniqueness => true
  
end