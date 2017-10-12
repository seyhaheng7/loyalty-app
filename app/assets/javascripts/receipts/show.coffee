Codingate.ReceiptsShow =
  init: ->
    @_initReceiptID()
    @_subcribedReceiptApprovalChannel()

  _initReceiptID: ->
    @receipt_id = $('#receipt-data').data('receipt-id')

  _subcribedReceiptApprovalChannel: ->
    self = @
    AppCable.receipt_approval = AppCable.cable.subscriptions.create "ReceiptApprovalChannel" ,
      connected: ->
        console.log "Connected To Receipt Approval Channel"

      disconnected: ->
        console.log "Disconnected From Receipt Approval Channel"

      received: (data) ->
        self._handleReceiptStatus(data["id"], data["status"])

  _handleReceiptStatus: (id, status) ->
    icon_reload = "<i class='fa fa-refresh'></i>"
    btn_reload_page = "<button class='btn btn-default' onClick='window.location.reload()'>"+icon_reload+" Reload Page</button>"

    if id == @receipt_id
      if status == "approved"
        $('#receipt-data').html "<span style='margin-right: 10px'>Receipt has been successfully approved!</span>"+btn_reload_page

      else if status == "rejected"
        $('#receipt-data').html "<span style='margin-right: 10px'>Receipt has been successfully rejected!</span>"+btn_reload_page

      else
        $('#receipt-data').html "<span style='margin-right: 10px'>Error Receipt Status!</span>"+btn_reload_page
