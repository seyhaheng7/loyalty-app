class Category < ApplicationRecord
  has_many :companies

  mount_uploader :icon, IconUploader

  validates :name, presence: true
  validates_uniqueness_of :name

  scope :name_like, ->{ where("name ilike '%#{value}%'") }

end
