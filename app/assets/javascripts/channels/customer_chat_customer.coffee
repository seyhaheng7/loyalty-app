# AppCable.customer_chat_customer = AppCable.cable.subscriptions.create 'CustomerChatCustomerChannel' ,
#  connected: ->
#    console.log "Connected To Customer Chat Customer Channel"

#  disconnected: ->
#    console.log "Disconnected From Customer Chat Customer Channel"

#  received: (data) ->
#    chat_datum = data["chat_datum"]
#    console.log chat_datum.text
#    console.log chat_datum.chat_room_id
    
#  speak: (data)->
#    @perform 'speak', text: data["text"], chat_room_id: data["chat_room_id"], customer_to_recieve_id: data["customer_to_recieve_id"]