class ChatRoomSerializer < ActiveModel::Serializer
  attributes :id
  has_many :customers
end