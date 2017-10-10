class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :long, :address
  attributes :errors
  belongs_to :company
  belongs_to :location
end
