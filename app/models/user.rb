class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable,
          :omniauthable, :secure_validatable, :lockable


  include DeviseTokenAuth::Concerns::User
end
