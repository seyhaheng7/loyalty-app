class Company < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :category
  has_many :stores

  validates :name, presence: true
  validates :address, presence: true

  mount_uploader :logo, LogoUploader

end
