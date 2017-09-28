class ContactForm < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :customer

  validates :subject, presence: true
  validates :message, presence: true
end
