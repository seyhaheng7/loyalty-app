class MerchantChatSupportSerializer < ActiveModel::Serializer
  attributes :id
  attributes :errors
  belongs_to :merchant
end
