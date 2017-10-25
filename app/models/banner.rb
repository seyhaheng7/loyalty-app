class Banner < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :advertisement
end
