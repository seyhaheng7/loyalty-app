class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # html = ApplicationController.render partial: "notifications/#{notification.objectable_type.underscore.pluralize}/#{notification.action}", locals: {notification: notification}, formats: [:html]
    ActionCable.server.broadcast "notifications:#{notification.notifyable_id}", html: html
  end
end
