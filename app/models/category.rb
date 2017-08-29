class Category < ApplicationRecord
  validates :name, presence: true

  mount_uploader :icon, IconUploader
end
