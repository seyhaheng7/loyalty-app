class ChatDatumSerializer < ActiveModel::Serializer
  attributes :id, :text, :sticker, :audio, :data_type, :created_at
  attributes :errors

  belongs_to :customer
end
