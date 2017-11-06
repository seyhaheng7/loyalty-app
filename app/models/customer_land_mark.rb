class CustomerLandMark < ApplicationRecord
  belongs_to :land_mark
  belongs_to :customer

  scope :today, ->{ where(created_at: (Time.now.beginning_of_day..Time.now.end_of_day)) }
  scope :in_date, ->(date){ where(created_at: (date.beginning_of_day..date.end_of_day)) }
end
