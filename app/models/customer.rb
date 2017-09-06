class Customer < ActiveRecord::Base
  acts_as_paranoid

  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable,
          :rememberable, :trackable, :omniauthable, :validatable,
          :lockable, :authentication_keys => [:phone]

  include DeviseTokenAuth::Concerns::User
  mount_uploader :avatar, ImageUploader

  has_many :receipts, dependent: :destroy
  has_many :claimed_rewards, dependent: :destroy
  has_many :operating_systems, dependent: :destroy

  reverse_geocoded_by :lat, :long

  before_validation :generate_uid_from_phone, if: :phone_provider?, on: :create

  GENDER = ['Male', 'Female']
  PROVIDERS = ['email', 'phone', 'facebook', 'google']

  # Generate Provider Scopes And Method (email_provider?, phone_provider? ...)
  PROVIDERS.each do |provider_name|
    scope "#{provider_name.downcase}_providers", -> { where(provider: provider_name) }
    define_method "#{provider_name.downcase.parameterize.underscore}_provider?" do
      self.provider == provider_name
    end
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

  private

  def generate_uid_from_phone
    self.uid = phone
  end
end
