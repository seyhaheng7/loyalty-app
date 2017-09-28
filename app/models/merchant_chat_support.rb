class MerchantChatSupport < ApplicationRecord
  belongs_to :merchant

  has_many :merchant_chat_support_data
end
