class Location < ApplicationRecord
  validates :name, presence: true
  validates_uniqueness_of :name

  scope :name_like, ->(name){ where("#{table_name}.name ilike ?", "%#{name}%") }

end
