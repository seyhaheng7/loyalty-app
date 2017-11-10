Codingate.CustomerChatSupportsMessageForm = Codingate.CustomerChatSupportsShow =
  init: ->
    @page = 1
    @_initCustomerChatSupportRoomID()
    @_handleInfinitScroll()
    @_loadCustomerChatSupportData()
    @_subcribedChannelCustomerChatSupport()
    @_handleMessageFormSubmitted()

  _scrollToBottom: ->
    $('#customer-chat-supports-list').scrollTop($("#chat-data")[0].scrollHeight);

  _initCustomerChatSupportRoomID: ->
    @room_id = $('#chat-data').data('room-id')

  _handleInfinitScroll: ->
    self = @
    list_of_chat_data = $('#customer-chat-supports-list')
    list_of_chat_data.scroll ->
      if list_of_chat_data.scrollTop() == 0
        self._loadCustomerChatSupportData()

  _loadCustomerChatSupportData: ->
    self = @
    $.getScript(window.location.href+".js?page=#{@page}").then ->
      if self.page == 1
        self._scrollToBottom()
      self.page++

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
        chat_datum = data["chat_datum"]
        self._appendChatSupportData(data["chat_datum"])

        if chat_datum.supportable_type == "Customer"
          setTimeout self._setSeenAtToDateNow, 100

      speak: (data)->
        @perform 'speak', text: data["text"], customer_chat_support_id: data["customer_chat_support_id"], action: 'speak'

  _handleMessageFormSubmitted: ->
    $('#message-form').submit (e) ->
      e.preventDefault()
      text = $('#text').val()
      customer_chat_support_id = $('#customer_chat_support_id').val()
      data = {text: text, customer_chat_support_id: customer_chat_support_id}
      AppCable.customer_chat_support.speak data
      $(this).trigger 'reset'

  _setSeenAtToDateNow: ->
    self = @
    $.ajax
      type: 'PATCH'
      url: window.location.href + '/seen_to_now'
      success: ->
