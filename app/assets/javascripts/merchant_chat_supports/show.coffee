Codingate.MerchantChatSupportsMessageForm = Codingate.MerchantChatSupportsShow =
  init: ->
    @page = 1
    @_initMerchantChatSupportRoomID()
    @_handleInfinitScroll()
    @_loadMerchantChatSupportData()
    @_subcribedChannelMerchantChatSupport()
    @_handleMessageFormSubmitted()

  _initMerchantChatSupportRoomID: ->
    @room_id = $('#chat-data').data('room-id')

  _handleInfinitScroll: ->
    self = @
    list_of_chat_data = $('#merchant-chat-supports-list')
    list_of_chat_data.scroll ->
      if list_of_chat_data.scrollTop() == 0
        self._loadMerchantChatSupportData()

  _loadMerchantChatSupportData: ->
    self = @
    $.getScript(window.location.href+".js?page=#{@page}").then ->
      self.page++

  _appendChatSupportData: (chat_datum)->
    self = @
    element_to_append = ""
    class_to_append = ""

    if chat_datum.supportable_type == "User"
      class_to_append = "message-sent"
    else
      class_to_append = 'message-received'

    element_to_append = '<li><div class="row"><div class="'+class_to_append+'">'+chat_datum.text+'</div></div></li>'

    $('#chat-data').append element_to_append

    height = $('#chat-data')[0].scrollHeight
    $('#merchant-chat-supports-list').scrollTop(height)

  _subcribedChannelMerchantChatSupport: ->
    self = @
    AppCable.merchant_chat_support = AppCable.cable.subscriptions.create {channel: "MerchantChatSupportChannel", room_id: @room_id} ,
      connected: ->
        console.log "Connected To Merchant Chat Support Channel"

      disconnected: ->
        console.log "Disconnected From Merchant Chat Support Channel"

      received: (data) ->
        chat_datum = data["chat_datum"]
        self._appendChatSupportData(chat_datum)

        if chat_datum.supportable_type == "Merchant"
          setTimeout self._setSeenAtToDateNow, 100

      speak: (data)->
        @perform 'speak', text: data["text"], merchant_chat_support_id: data["merchant_chat_support_id"]

  _handleMessageFormSubmitted: ->
    $('#message-form').submit (e) ->
      e.preventDefault()
      text = $('#text').val()
      merchant_chat_support_id = $('#merchant_chat_support_id').val()
      data = {text: text, merchant_chat_support_id: merchant_chat_support_id}
      AppCable.merchant_chat_support.speak data
      $(this).trigger 'reset'

  _setSeenAtToDateNow: ->
    self = @
    $.ajax
      type: 'PATCH'
      url: window.location.href + '/seen_to_now'
      success: ->
