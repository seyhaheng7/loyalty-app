class LocationSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  attributes :errors
end
