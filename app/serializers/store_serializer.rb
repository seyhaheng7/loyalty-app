class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :long, :address, :distance
  attributes :errors
  belongs_to :company
  belongs_to :location

  def distance
    if object.respond_to?(:distance)
      object.distance
    end
  end
end
