class RewardSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :require_points, :quantity, :price
  attributes :errors
  belongs_to :store
end
