class Company < ApplicationRecord
  belongs_to :category
  has_many :stores

  has_many :stores
  acts_as_paranoid
  
  validates :name, presence: true
  validates :address, presence: true

  mount_uploader :logo, LogoUploader

  scope :partners, -> { where(partner: true) }
  scope :in_category, ->(category_id){ where(category_id: category_id) }

end
