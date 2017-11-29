# Contact Form feature has been temporary removed
class ContactForm < ApplicationRecord
  acts_as_paranoid

  belongs_to :customer

  validates :subject, presence: true
  validates :message, presence: true

  delegate :name, to: :customer, prefix: true, allow_nil: true

  scope :subject_like, ->(subject){ where("#{table_name}.subject ilike ?", "%#{subject}%") }
  scope :message_like, ->(message){ where("#{table_name}.message ilike ?", "%#{message}%") }

end
