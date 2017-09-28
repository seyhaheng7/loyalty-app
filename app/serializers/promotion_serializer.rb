class PromotionSerializer < ActiveModel::Serializer
  attributes :id, :title, :image, :body, :start_date, :end_date
end
