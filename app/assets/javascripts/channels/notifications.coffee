$(document).ready ->
  user_signed_in = $('body').data('user-signed-in')
  if user_signed_in
    AppCable.notifications = AppCable.cable.subscriptions.create 'NotificationsChannel',

      connected: ->
        console.log 'Connected to Notification'

      disconnected: ->
        console.log 'Disconnected from Notification'

      received: (notification) ->
        console.log notification
        $('#pending-notifications-count').html notification.pending_notifications_count