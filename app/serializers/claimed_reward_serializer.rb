class ClaimedRewardSerializer < ActiveModel::Serializer
  attributes :id, :status, :reward_id, :errors
  belongs_to :customer
  belongs_to :reward
end
