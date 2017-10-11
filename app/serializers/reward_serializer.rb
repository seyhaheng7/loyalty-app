class RewardSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :require_points, :quantity, :price, :description
  attributes :errors
  belongs_to :store
end
