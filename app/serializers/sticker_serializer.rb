class StickerSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :errors
end
