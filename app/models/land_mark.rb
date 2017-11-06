class LandMark < ApplicationRecord
  has_many :customer_land_marks, dependent: :destroy
  scope :name_like, ->(name){ where("#{table_name}.name ilike ?", "%#{name}%") }
end
