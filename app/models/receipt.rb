class Receipt < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :store
  belongs_to :user

  mount_base64_uploader :capture, ImageUploader

  validates :receipt_id, presence: true
  validates :total, presence: true
  validates :capture, presence: true
  validates :receipt_id, :uniqueness => {:scope => :store_id, message: "Receipt is already submitted"} 
end
