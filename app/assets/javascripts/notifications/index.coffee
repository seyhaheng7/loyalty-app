Codingate.NotificationsIndex = 
  init: ->  
    @page = 1
    @_handleInfinitScroll()
    @_loadNotifications()

  _handleInfinitScroll: ->
    self = @
    $(window).scroll ->
      if $(window).scrollTop() + $(window).height() == $(document).height()
        self._loadNotifications()

  _loadNotifications: ->
    self = @
    $.getScript("/notifications.js?page=#{@page}").then ->
      self.page++
    