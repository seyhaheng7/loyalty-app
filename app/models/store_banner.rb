class StoreBanner < ApplicationRecord
  
  mount_uploader :image, ImageUploader
  belongs_to :store

end
