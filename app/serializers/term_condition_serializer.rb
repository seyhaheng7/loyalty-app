class TermConditionSerializer < ActiveModel::Serializer
  attributes :id, :body
  attributes :errors
end
