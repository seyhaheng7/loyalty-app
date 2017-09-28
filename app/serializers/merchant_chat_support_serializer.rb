class MerchantChatSupportSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :merchant
end
