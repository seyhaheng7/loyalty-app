class Category < ApplicationRecord
  acts_as_paranoid
  has_many :companies

  mount_uploader :icon, IconUploader

  validates :name, presence: true
  validates_uniqueness_of :name

  scope :name_like, ->(name){ where("#{table_name}.name ilike ?", "%#{name}%") }

end
