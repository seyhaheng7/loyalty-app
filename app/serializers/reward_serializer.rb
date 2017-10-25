class RewardSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :require_points, :quantity, :price, :description, :start_date, :end_date
  attributes :errors
  belongs_to :store
end
