class CustomerChatSupport < ApplicationRecord
  belongs_to :customer

  has_many :customer_chat_support_data

  delegate :avatar, to: :customer, prefix: true, allow_nil: true
  delegate :name, to: :customer, prefix: true, allow_nil: true
end
