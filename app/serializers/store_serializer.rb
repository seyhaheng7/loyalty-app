class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :long, :address
  belongs_to :company
  belongs_to :location
end
