class ClaimedRewardSerializer < ActiveModel::Serializer
  attributes :id, :status, :reward_id, :errors, :qr_token
  belongs_to :customer
  belongs_to :reward
end
