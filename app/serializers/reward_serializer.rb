class RewardSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :require_points, :quantity, :price
  belongs_to :store
end
