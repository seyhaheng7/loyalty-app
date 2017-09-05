class ClaimedRewardSerializer < ActiveModel::Serializer
  attributes :id, :status, :user_id, :reward_id, :errors
  belongs_to :user
  belongs_to :reward
end
