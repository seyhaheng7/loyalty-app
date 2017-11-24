class Category < ApplicationRecord
  acts_as_paranoid
  has_many :companies, dependent: :destroy

  mount_uploader :icon, IconUploader

  validates :name, presence: true
  validates_uniqueness_of :name

  scope :name_like, ->(name){ where("#{table_name}.name ilike ?", "%#{name}%") }

  default_scope { order(:sort_order) }

  def self.update_order(ids)
    where(id: ids).update_all(["sort_order = STRPOS(?, ','||id||',')", ",#{ids.join(',')},"])
  end
end
