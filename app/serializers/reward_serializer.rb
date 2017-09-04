class RewardSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :require_points, :quantity
  has_one :company
end
