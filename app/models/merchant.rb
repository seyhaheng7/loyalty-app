class Merchant < ActiveRecord::Base
  acts_as_paranoid

  # Include default devise modules.
  devise :database_authenticatable, :recoverable,
    :rememberable, :trackable, :validatable, :authentication_keys => [:phone]

  include DeviseTokenAuth::Concerns::User

  belongs_to :store

  before_validation :generate_uid_from_phone, if: :phone_provider?, on: :create

  PROVIDERS = ['email', 'phone', 'facebook', 'google']

  # Create provider scopes and method (phone_provider? ...)
  PROVIDERS.each do |provider_name|
    scope "#{provider_name.downcase}_providers", -> { where(provider: provider_name) }
    define_method "#{provider_name.downcase.parameterize.underscore}_provider?" do
      provider == provider_name
    end
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
