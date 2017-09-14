class Location < ApplicationRecord
  validates :name, presence: true
  validates_uniqueness_of :name

  scope :name_like, ->(value){ where("#{table_name}.name ilike ?", value) }

end
