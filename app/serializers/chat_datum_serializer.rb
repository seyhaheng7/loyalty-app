class ChatDatumSerializer < ActiveModel::Serializer
  attributes :id, :text, :sticker, :audio, :data_type
  attributes :errors
  
  belongs_to :customer
end
