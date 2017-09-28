AppCable.notifications = AppCable.cable.subscriptions.create("NotificationsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
    console.log('connected to notification')
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(notification) {
    console.log(notification)
    // Called when there's incoming data on the websocket for this channel
    $("#pending-notifications-count").html(notification.pending_notifications_count);
  }
});