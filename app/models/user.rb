class User < ActiveRecord::Base
  # Add validation and bcrypt
  has_secure_password

  # to make sure email is unique
  before_save { self.email = email.downcase }
  # before_create { generate_token(:auth_token) }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false }
  validates :password, length: { minimum: 6 }

end