class User < ActiveRecord::Base
  # Add validation and bcrypt
  has_secure_password
  #attr_accessible :email, :password
  # to make sure email is unique
  before_save { self.email = email.downcase }
  before_create { generate_token(:auth_token) }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false }
  #validates :password
  #, length: { minimum: 6 }


  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    binding.pry
    save!
    UserMailer.password_reset(self).deliver
  end
end

class MailChimp
  API_KEY = 'ada35c652d5037f179ff96acda36d9a1-us8'.freeze
  LIST_ID = '654e61cede'.freeze

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
