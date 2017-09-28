class AdvertisementSerializer < ActiveModel::Serializer
  attributes :id, :name, :banner, :active, :for_page, :lat, :long, :address, :phone, :web_site, :start_date, :end_date
end
