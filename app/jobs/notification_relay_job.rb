class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(*args)
    html = ApplicationController.render partial: "notifications/top_nav", locals: {notification: notification}, formats: [:html]
    ActionCable.server.broadcast "notifications:#{notification.notifyable_id}", html: html
  end
end
