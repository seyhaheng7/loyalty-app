class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :long, :address, :distance, :phone_number, :facebook, :open_and_close, :email, :website, :banners, :term_and_condition
  attributes :errors
  belongs_to :company
  belongs_to :location

  def phone_number
    object.phone.to_s.split(',').map(&:strip)
  end

  def banners
    object.store_banners
  end

  def distance
    if object.respond_to?(:distance)
      object.distance
    end
  end
end
