class CustomerChatSupport < ApplicationRecord
  belongs_to :customer

  has_many :customer_chat_support_data
end
