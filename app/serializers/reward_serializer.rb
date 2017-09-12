class RewardSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :require_points, :quantity, :approved_claimed_rewards_count
  belongs_to :store
end
