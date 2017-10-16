class Customer < ActiveRecord::Base
  acts_as_paranoid

  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable,
          :rememberable, :trackable, :omniauthable, :validatable,
          :lockable, :authentication_keys => [:phone]

  include DeviseTokenAuth::Concerns::User
  mount_base64_uploader :avatar, ImageUploader

  validates :phone,:presence => true, uniqueness: { message: "already registered" }
  validates :phone, numericality: { message: 'Not a phone number' },
              length: { minimum: 9, maximum: 10, message: 'Not a phone number' }

  has_many :receipts, dependent: :destroy
  has_many :claimed_rewards, dependent: :destroy
  has_many :operating_systems, dependent: :destroy
  has_many :contact_forms, dependent: :destroy
  has_one :customer_chat_support
  has_many :customer_chat_support_data, as: :supportable
  has_many :devices, as: :deviceable
  has_many :notifications, as: :notifyable
  has_many :view_video_ads, dependent: :destroy
  has_many :max_view_video_ads, -> { reach_max_views }, class_name: 'ViewVideoAd'
  has_many :max_video_ads, through: :max_view_video_ads, class_name: 'VideoAd', source: :video_ad
  has_many :chat_members
  has_many :chat_rooms, through: :chat_members


  scope :able_to_verify,        ->{ where('verification_expired_at > ?', DateTime.now) }
  scope :digit_not_yet_expired, ->{ where('digit_expired_at > ?', DateTime.now) }
  scope :verified,              ->{ where.not(verified_at: nil) }
  scope :name_like,             ->(name){ where("#{table_name}.first_name || #{table_name}.last_name ilike ?", "%#{name}%") }
  scope :active,                ->{ where("update_location_at > ?", DateTime.now - 30.minutes) }

  reverse_geocoded_by :lat, :long

  GENDER = ['Male', 'Female']
  PROVIDERS = ['email', 'phone', 'facebook', 'google']

  # Generate Provider Scopes And Method (email_provider?, phone_provider? ...)
  PROVIDERS.each do |provider_name|
    scope "#{provider_name.downcase}_providers", -> { where(provider: provider_name) }
    define_method "#{provider_name.downcase.parameterize.underscore}_provider?" do
      self.provider == provider_name
    end
  end


  before_validation :generate_uid_from_phone, if: :phone_provider?, on: :create
  before_save :generate_verification_code, unless: :verified?, if: :phone_changed?
  before_save :change_update_location_at, if: :location_changed?

  after_create :create_customer_chat_support
  after_commit :broadcast_location, if: :saved_change_to_location?
  after_save :send_comfirmation_code, unless: :verified?, if: :saved_change_to_phone?

  def digit_expired?
    digit_expired_at < DateTime.now
  end

  def valid_digit?(digit)
    !digit_expired? && digit == login_digit
  end

  def verified?
    verified_at.present?
  end

  def confirm!
    update(verified_at: DateTime.now)
  end

  def completed_profile?
    phone.present? and first_name.present? and last_name.present?
  end

  def send_login_digit
    self.login_digit      = generate_4_digit
    self.digit_expired_at = DateTime.now + 10.minutes
    save
    text = "Your login digit is #{login_digit} will expired in 10 minutes"
    SendSmsWorker.perform_async(phone, text)
  end

  def add_points(points)
    self.current_points = current_points.to_i + points.to_i
    save
  end

  def sub_points(reward_points)
    self.current_points = current_points.to_i - reward_points.to_i
    save
  end

  # Prevent Devise Validate Email Start
  # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-with-something-other-than-their-email-address
  def email_required?
    false
  end

  def email_changed?
    false
  end
  # Prevent Devise Validate Email End

  def name
    "#{first_name} #{last_name}"
  end

  private

  def generate_verification_code
    self.verified_at             = nil
    self.verification_code       = generate_4_digit
    self.verification_expired_at = DateTime.now + 10.minutes
  end

  def send_comfirmation_code
    text = "Your verification code is #{verification_code} will expired in 10 minutes"
    SendSmsWorker.perform_async(phone, text)
  end

  def generate_4_digit
    '%04d' % Random.rand(2..9999)
  end

  def generate_uid_from_phone
    self.uid = phone
  end

  def create_customer_chat_support
    CustomerChatSupport.create!(customer_id: id)
  end

  def broadcast_location
    UpdateCustomerLocationWorker.perform_async id
  end

  def saved_change_to_location?
    saved_change_to_lat? || saved_change_to_long?
  end

  def location_changed?
    lat_changed? || long_changed?
  end

  def change_update_location_at
    self.update_location_at = DateTime.now
  end

end
