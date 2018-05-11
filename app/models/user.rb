class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_one :bank, inverse_of: :user, dependent: :destroy
  has_many :bills, through: :bank
  has_many :transactions, through: :bank
  has_many :recurrences, through: :bank
  has_many :exclusions, through: :bank

  scope :public_user, -> { where(public: true).first }

  after_create :create_bank

  private

  def create_bank
    Bank.create(user_id: self.id, balance: 0) if bank.nil?
  end

end
