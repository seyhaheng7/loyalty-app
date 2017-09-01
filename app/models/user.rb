class User < ActiveRecord::Base

  # Include default devise modules.
  acts_as_paranoid
  devise :database_authenticatable, :registerable, :recoverable,
          :rememberable, :trackable, :omniauthable, :secure_validatable
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

  has_many :receipts

  def add_points(points)
    self.current_points = current_points.to_i + points.to_i
    self.save
  end
end
