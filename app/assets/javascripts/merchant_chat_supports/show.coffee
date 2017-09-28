Codingate.MerchantChatSupportsMessageForm = Codingate.MerchantChatSupportsShow =
  init: ->
    @_initMerchantChatSupportRoomID()
    @_getMerchantChatSupportData()
    @_subcribedChannelMerchantChatSupport()
    @_handleMessageFormSubmitted()

  _initMerchantChatSupportRoomID: ->
    @room_id = $('#chat-data').data('room-id')

  _getMerchantChatSupportData: ->
    self = @
    $.ajax
      url: window.location.href + '.json'
      dataType: 'json'
      success: (chat_data) ->
        for chat_datum in chat_data
          self._appendChatSupportData(chat_datum)

  _appendChatSupportData: (chat_datum)->
    element_to_append = ""
    class_to_append = ""

    if chat_datum.supportable_type == "User"
      class_to_append = "message-sent"
    else
      class_to_append = 'message-received'

    element_to_append = '<li><div class="row"><div class="'+class_to_append+'">'+chat_datum.text+'</div></div></li>'

    $('#chat-data').append element_to_append

    height = $('#chat-data')[0].scrollHeight;
    $('#merchant-chat-supports-list').scrollTop(height);

  _subcribedChannelMerchantChatSupport: ->
    self = @
    AppCable.merchant_chat_support = AppCable.cable.subscriptions.create {channel: "MerchantChatSupportChannel", room_id: @room_id} ,
      connected: ->
        console.log "Connected To Merchant Chat Support Channel"

      disconnected: ->
        console.log "Disconnected From Merchant Chat Support Channel"

      received: (data) ->
        self._appendChatSupportData(data["chat_datum"])

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
