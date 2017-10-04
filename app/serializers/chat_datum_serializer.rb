class ChatDatumSerializer < ActiveModel::Serializer
  attributes :id, :text, :sticker, :data_type
  belongs_to :customer
end