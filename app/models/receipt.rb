class Receipt < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :store
  belongs_to :user

  mount_uploader :capture, ImageUploader

  validates :receipt_id, presence: true
  validates :total, presence: true
  validates :capture, presence: true


end
