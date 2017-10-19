class CustomerChatSupport < ApplicationRecord
  belongs_to :customer

  has_many :customer_chat_support_data

  scope :lastest_chat_order, -> { select('customer_chat_supports.*,MAX(customer_chat_support_data.created_at) as last').joins(:customer_chat_support_data).order('last DESC').group(:id) }

  delegate :avatar, to: :customer, prefix: true, allow_nil: true
  delegate :name, to: :customer, prefix: true, allow_nil: true

  after_commit :broadcast_active_chat_support, if: :saved_change_to_seen_at?

  def set_seen_at_to_blank
    self.seen_at = nil
    save
  end

  private
  
    def broadcast_active_chat_support
      CustomerActiveChatSupportWorker.perform_async id
    end

end
