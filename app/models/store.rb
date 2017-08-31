class Store < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :company
  belongs_to :location
  has_many :receipts

  validates :name, presence: true

end
