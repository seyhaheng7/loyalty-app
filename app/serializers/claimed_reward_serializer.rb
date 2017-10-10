class ClaimedRewardSerializer < ActiveModel::Serializer
  attributes :id, :status, :reward_id, :errors, :qr_token
  attributes :errors
  attributes :store, :store_location

  belongs_to :customer
  belongs_to :reward
end
