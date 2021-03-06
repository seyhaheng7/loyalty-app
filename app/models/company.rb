class Company < ApplicationRecord
  belongs_to :category
  has_many :stores, dependent: :destroy

  acts_as_paranoid

  validates :name, presence: true
  validates :address, presence: true
  validates_uniqueness_of :name
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, allow_blank: true
  validates :logo, presence: true
  validates :logo, file_geometry: {is: [250, 166]}, if: :logo_changed?

  mount_uploader :logo, LogoUploader

  delegate :name, to: :category, prefix: true, allow_nil: true

  default_scope { order(created_at: :desc) }
  scope :partners, -> { where(partner: true) }
  scope :in_category, ->(category_id){ where(category_id: category_id) }
  scope :name_like, ->(name){ where("#{table_name}.name ilike ?", "%#{name}%") }

end
