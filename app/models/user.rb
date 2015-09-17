class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  has_many :accounts
  has_many :banks
  has_many :bills, :through => :accounts
  has_many :transactions, :through => :banks


    before_save :ensure_authentication_token

    def ensure_authentication_token
      self.authentication_token ||= generate_authentication_token
    end

    private

    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).first
      end
    end
end
