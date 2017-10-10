class StickerGroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :errors
  has_many :stickers
end
