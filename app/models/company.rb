class Company < ApplicationRecord
  belongs_to :category
  has_many :stores

  has_many :stores
  acts_as_paranoid
  
  validates :name, presence: true
  validates :address, presence: true

  mount_uploader :logo, LogoUploader

end
