class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :long, :address
  has_one :company
  has_one :location
end
