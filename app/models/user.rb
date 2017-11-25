class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable,
         :authentication_keys => [:email]

  acts_as_paranoid

  has_many :devices, as: :deviceable, dependent: :destroy
  has_many :notifications, as: :notifyable, dependent: :destroy
  has_many :customer_chat_support_data, as: :supportable, dependent: :destroy
  has_many :merchant_chat_support_data, as: :supportable, dependent: :destroy

  mount_uploader :avatar, ImageUploader

  ROLES = ['Admin', 'Approver']

  # Create role scopes and methods (super? admin? ...)
  ROLES.each do |role_name|
    scope role_name.downcase, -> { where(role: role_name) }
    define_method "#{role_name.downcase.parameterize.underscore}?" do
      role == role_name
    end
  end

  validates :role, presence: true

  default_scope { order(created_at: :desc) }
  scope :name_like, ->(name){ where("#{table_name}.name ilike ?", "%#{name}%") }
  scope :admin_or_approver, ->{ admin.or(approver) }

  def reset_pending_notifications
    self.pending_notifications_count = 0
    save
  end

  def increase_pending_notifications
    self.pending_notifications_count += 1
    save(validate: false)
  end

end
