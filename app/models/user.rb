class User < ActiveRecord::Base

  # Include default devise modules.
  acts_as_paranoid
  devise :database_authenticatable, :registerable, :recoverable,
          :rememberable, :trackable, :omniauthable, :validatable
          :lockable

  include DeviseTokenAuth::Concerns::User
  mount_uploader :avatar, ImageUploader

  GENDER = ['Male', 'Female']
  ROLE = ['Super', 'Admin', 'Customer', 'Merchant']

  ROLE.each do |role_name|
    scope role_name.downcase, -> { where(role: role_name) }
    define_method "#{role_name.downcase.parameterize.underscore}?" do
      role == role_name
    end
  end

  validates :role, presence: true

  has_many :receipts, dependent: :destroy


  # Login with Email And Phone Start

  # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-with-something-other-than-their-email-address
  def email_required?
    admin? || super?
  end

  # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-with-something-other-than-their-email-address
  def email_changed?
    super && ( admin? || super? )
  end

  #https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  attr_accessor :login
  def login=(login)
    @login = login
  end

  def login
    @login ||=  if admin? || supper?
                  self.email
                else
                  self.phone
                end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      customer_condition = "(lower(phone) = :value AND role = 'Customer')"
      admin_condition    = "(lower(email) = :value AND role = 'Admin')"
      where(conditions).where(["#{customer_condition} OR #{admin_condition}", { :value => login.downcase }]).first
    elsif conditions.has_key?(:phone) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      customer_condition = '(lower(phone) = :value AND role = "Customer")'
      admin_condition    = '(lower(email) = :value AND role = "Admin")'
      where(conditions).where(["#{customer_condition} OR #{admin_condition}", { :value => login.downcase }]).first
    else
      if conditions[:phone].blank?
        where(conditions).first
      else
        where(phone: conditions[:phone]).first
      end
    end
  end
  # End Login with Email And Phone

  def add_points(points)
    self.current_points = current_points.to_i + points.to_i
    save
  end
end
