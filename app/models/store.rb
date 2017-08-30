class Store < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :company
  belongs_to :location

  validates :name, presence: true

end
