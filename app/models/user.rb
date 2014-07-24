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

class MailChimp
  API_KEY = '4e3fca8ec0ee884aead1ffca4448e56a-us8'.freeze
  LIST_ID = '8f5ae28436'.freeze

  class << self
    def subscribe_to_mailing_list(user_id)
      user = User.find(user_id)

      if LIST_ID
        gb = Gibbon::API.new(API_KEY)
        gb.lists.subscribe({:id => LIST_ID, :email => {:email => user.email}, double_optin: false })
      end
    end
  end
end
