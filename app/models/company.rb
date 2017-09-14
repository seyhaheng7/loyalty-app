class Company < ApplicationRecord
  belongs_to :category
  has_many :stores

  acts_as_paranoid

  validates :name, presence: true
  validates :address, presence: true
  validates_uniqueness_of :name

  mount_uploader :logo, LogoUploader

  scope :partners, -> { where(partner: true) }
  scope :in_category, ->(category_id){ where(category_id: category_id) }
  scope :name_like, ->(name){ where("#{table_name}.name ilike ?", "%#{name}%") }

end
