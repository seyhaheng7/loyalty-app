class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :icon
  attributes :errors
end
