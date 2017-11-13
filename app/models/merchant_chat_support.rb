class MerchantChatSupport < ApplicationRecord
  belongs_to :merchant

  has_many :merchant_chat_support_data

  scope :lastest_chat_order, -> { select('merchant_chat_supports.*,MAX(merchant_chat_support_data.created_at) as last').joins(:merchant_chat_support_data).order('last DESC').group(:id) }

  delegate :avatar, to: :merchant, prefix: true, allow_nil: true
  delegate :name, to: :merchant, prefix: true, allow_nil: true

  after_commit :broadcast_active_chat_support, if: :saved_change_to_seen_at?

  def set_seen_at_to_blank
    self.seen_at = nil
    save
  end

  private

    def broadcast_active_chat_support
      if !merchant_chat_support.admin_streaming?
        MerchantActiveChatSupportWorker.perform_async id
      end
    end
end
