class CustomerChatSupportSerializer < ActiveModel::Serializer
  attributes :id
  attributes :errors
  belongs_to :customer
end
