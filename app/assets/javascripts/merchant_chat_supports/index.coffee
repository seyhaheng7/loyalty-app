Codingate.MerchantChatSupportsIndex = 
  init: ->  
    @page = 1
    @_handleInfinitScroll()
    @_loadMerchantChatSupports()
    @_subcribedChannelMerchantActiveChatSupport()

  _handleInfinitScroll: ->
    self = @
    $(window).scroll ->
      if $(window).scrollTop() + $(window).height() == $(document).height()
        self._loadMerchantChatSupports()

  _loadMerchantChatSupports: ->
    self = @
    $.getScript("/merchant_chat_supports.js?page=#{@page}").then ->
      self.page++

  _subcribedChannelMerchantActiveChatSupport: ->
    self = @
    AppCable.merchant_active_chat_support = AppCable.cable.subscriptions.create "MerchantActiveChatSupportChannel",
      connected: ->
        console.log "Connected To Merchant Active Chat Support Channel"

      disconnected: ->
        console.log "Disconnected From Merchant Active Chat Support Channel"

      received: (data) ->
        id_room = data.id
        seen_at = data.seen_at

        if seen_at == null
          $('#chat-now-btn-'+id_room).attr 'class', 'btn btn-danger chat-btn'
        else
          $('#chat-now-btn-'+id_room).attr 'class', 'btn btn-primary chat-btn'
    