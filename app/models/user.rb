class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable,
         :authentication_keys => [:email]


  mount_uploader :avatar, ImageUploader

  ROLES = ['Super', 'Admin', 'Receptionist', 'Approver']

  # Create role scopes and methods (super? admin? ...)
  ROLES.each do |role_name|
    scope role_name.downcase, -> { where(role: role_name) }
    define_method "#{role_name.downcase.parameterize.underscore}?" do
      role == role_name
    end
  end

  validates :role, presence: true
  validates :name, presence: true
  
  has_many :customer_chat_support_data, as: :supportable

  scope :name_like, ->(name){ where("#{table_name}.name ilike ?", "%#{name}%") }

end
