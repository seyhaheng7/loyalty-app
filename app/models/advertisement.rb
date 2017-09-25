class Advertisement < ApplicationRecord
  acts_as_paranoid

  validates :name, presence: true
  validates :banner, presence:true

  mount_uploader :banner, BannerUploader
end
