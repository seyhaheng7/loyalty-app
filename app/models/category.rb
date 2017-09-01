class Category < ApplicationRecord
  validates :name, presence: true
  has_many :companies
  
  mount_uploader :icon, IconUploader
end
