class ChatDatumSerializer < ActiveModel::Serializer
  attributes :id, :text
  belongs_to :chat_room
  belongs_to :customer
end