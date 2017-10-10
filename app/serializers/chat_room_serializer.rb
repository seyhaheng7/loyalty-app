class ChatRoomSerializer < ActiveModel::Serializer
  attributes :id
  attributes :errors
  has_many :customers
end
