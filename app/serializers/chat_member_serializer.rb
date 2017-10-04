class ChatMemberSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :customer
end