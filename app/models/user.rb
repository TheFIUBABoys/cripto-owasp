class User < ActiveRecord::Base
  has_secure_password

  # Password validations
  validates :password, length: { minimum: 5 }
  validates_confirmation_of :password

  # Email validations
  validates_uniqueness_of :email

  has_one :session
end
