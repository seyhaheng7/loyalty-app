class Faq < ApplicationRecord
  acts_as_paranoid
  validates :title, presence: true

  default_scope { order(created_at: :desc) }

  scope :title_like, ->(title){ where("#{table_name}.title ilike ?", "%#{title}%") }

end
