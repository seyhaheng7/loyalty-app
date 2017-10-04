class MerchantChatSupport < ApplicationRecord
  belongs_to :merchant

  has_many :merchant_chat_support_data

  delegate :avatar, to: :merchant, prefix: true, allow_nil: true
  delegate :name, to: :merchant, prefix: true, allow_nil: true
end
