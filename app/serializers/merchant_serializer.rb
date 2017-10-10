class MerchantSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  attributes :errors
end
