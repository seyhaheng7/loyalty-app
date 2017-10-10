class PrivacyPolicySerializer < ActiveModel::Serializer
  attributes :id, :body
  attributes :errors
end
