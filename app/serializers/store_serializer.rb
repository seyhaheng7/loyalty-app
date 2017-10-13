class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :long, :address, :distance, :phone, :facebook, :open_and_close, :email
  attributes :errors
  belongs_to :company
  belongs_to :location

  def distance
    if object.respond_to?(:distance)
      object.distance
    end
  end
end
