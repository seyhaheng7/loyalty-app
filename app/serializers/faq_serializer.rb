class FaqSerializer < ActiveModel::Serializer
  attributes :id, :title, :content
  attributes :errors
end
