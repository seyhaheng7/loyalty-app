Codingate.CustomerChatSupportsIndex = 
  init: ->  
    @page = 1
    @_handleInfinitScroll()
    @_loadCustomerChatSupports()
    @_subcribedChannelCustomerActiveChatSupport()

  _handleInfinitScroll: ->
    self = @
    $(window).scroll ->
      if $(window).scrollTop() + $(window).height() == $(document).height()
        self._loadCustomerChatSupports()

  _loadCustomerChatSupports: ->
    self = @
    $.getScript("/customer_chat_supports.js?page=#{@page}").then ->
      self.page++

  _subcribedChannelCustomerActiveChatSupport: ->
    self = @
    AppCable.customer_active_chat_support = AppCable.cable.subscriptions.create "CustomerActiveChatSupportChannel",
      connected: ->
        console.log "Connected To Customer Active Chat Support Channel"

      disconnected: ->
        console.log "Disconnected From Customer Active Chat Support Channel"

      received: (data) ->
        id_room = data.id
        seen_at = data.seen_at

        if seen_at == null
          $('#chat-now-btn-'+id_room).attr 'class', 'btn btn-danger chat-btn'
        else
          $('#chat-now-btn-'+id_room).attr 'class', 'btn btn-primary chat-btn'

    