class ClaimedRewardSerializer < ActiveModel::Serializer
  attributes :id, :status, :reward_id, :errors, :qr_token, :given, :expired_at, :is_expired
  attributes :errors
  attributes :store, :store_location

  belongs_to :customer
  belongs_to :reward

  def is_expired
    object.expired?
  end
end
