class RewardSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :require_points, :quantity
  belongs_to :company
end
