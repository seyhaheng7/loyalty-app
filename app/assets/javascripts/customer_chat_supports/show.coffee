Codingate.CustomerChatSupportsMessageForm = Codingate.CustomerChatSupportsShow =
  init: ->
    @_initCustomerChatSupportRoomID()
    @_getCustomerChatSupportData()
    @_subcribedChannelCustomerChatSupport()
    @_handleMessageFormSubmitted()

  _initCustomerChatSupportRoomID: ->
    @room_id = window.location.href.split("/")[4].split("?")[0]

  _getCustomerChatSupportData: ->
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
    $('#customer-chat-supports-list').scrollTop(height);

  _subcribedChannelCustomerChatSupport: ->
    self = @
    AppCable.customer_chat_support = AppCable.cable.subscriptions.create {channel: "CustomerChatSupportChannel", room_id: @room_id} ,
      connected: ->
        console.log "Connected To Customer Chat Support Channel"

      disconnected: ->
        console.log "Disconnected From Customer Chat Support Channel"

      received: (data) ->
        self._appendChatSupportData(data["chat_datum"])

      speak: (data)->
        @perform 'speak', text: data["text"], customer_chat_support_id: data["customer_chat_support_id"]

  _handleMessageFormSubmitted: ->
    $('#message-form').submit (e) ->
      e.preventDefault()
      text = $('#text').val()
      customer_chat_support_id = $('#customer_chat_support_id').val()
      data = {text: text, customer_chat_support_id: customer_chat_support_id}
      AppCable.customer_chat_support.speak data
      $(this).trigger 'reset'