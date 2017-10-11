class Merchant < ActiveRecord::Base
  acts_as_paranoid

  has_one :merchant_chat_support
  has_many :merchant_chat_support_data, as: :supportable
  has_many :devices, as: :deviceable
  has_many :notifications, as: :notifyable

  # Include default devise modules.
  devise :database_authenticatable, :recoverable, :registerable,
    :rememberable, :trackable, :validatable, :authentication_keys => [:phone]

  include DeviseTokenAuth::Concerns::User

  mount_uploader :avatar, ImageUploader

  belongs_to :store

  validates :name, presence: true
  validates :phone,:presence => true, uniqueness: { message: "already registered" }
  validates :phone, numericality: { message: 'Not a phone number' },
              length: { minimum: 8, maximum: 9, message: 'Not a phone number' }


  before_validation :generate_uid_from_phone, if: :phone_provider?, on: :create

  after_create :create_merchant_chat_support

  PROVIDERS = ['email', 'phone', 'facebook', 'google']

  # Create provider scopes and method (phone_provider? ...)
  PROVIDERS.each do |provider_name|
    scope "#{provider_name.downcase}_providers", -> { where(provider: provider_name) }
    define_method "#{provider_name.downcase.parameterize.underscore}_provider?" do
      provider == provider_name
    end
  end

  scope :name_like, ->(name){ where("#{table_name}.name ilike ?", "%#{name}%") }

  delegate :name, to: :store, prefix: true, allow_nil: true
  delegate :claimed_rewards, to: :store, allow_nil: true

  # Prevent Devise Validate Email Start
  # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-with-something-other-than-their-email-address
  def email_required?
    false
  end

  def email_changed?
    false
  end
  # Prevent Devise Validate Email End

  private

  def generate_uid_from_phone
    self.uid = phone
  end

  def create_merchant_chat_support
    MerchantChatSupport.create!(merchant_id: id)
  end
end
