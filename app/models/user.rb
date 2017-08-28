class User < ActiveRecord::Base
  # Include default devise modules.
  acts_as_paranoid
  devise :database_authenticatable, :registerable, :recoverable, 
          :rememberable, :trackable,:omniauthable, :secure_validatable,
          :lockable

  # include DeviseTokenAuth::Concerns::User

  mount_uploader :avatar, ImageUploader

end
