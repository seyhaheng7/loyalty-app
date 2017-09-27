class NotificationsWorker
  include Sidekiq::Worker

  def perform(notification_id)
    sleep 1
    notification = Notification.find notification_id
    user = notification.notifyable
    ActionCable.server.broadcast "notifications_channel_#{notification.notifyable_id}", pending_notifications_count: user.pending_notifications_count
  end
end
