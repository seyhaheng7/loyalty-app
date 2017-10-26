class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :long, :address, :distance, :phone, :facebook, :open_and_close, :email, :website, :banners
  attributes :errors
  belongs_to :company
  belongs_to :location

  def banners
    object.store_banners
  end

  def distance
    if object.respond_to?(:distance)
      object.distance
    end
  end
end
