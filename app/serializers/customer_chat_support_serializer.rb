class CustomerChatSupportSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :customer
end
