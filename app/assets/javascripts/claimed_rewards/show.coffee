Codingate.ClaimedRewardsShow =
  init: ->
    @_initClaimedRewardID()
    @_subcribedClaimedRewardApprovalChannel()

  _initClaimedRewardID: ->
    @claimed_reward_id = $('#claimed-reward-data').data('claimed-reward-id')

  _subcribedClaimedRewardApprovalChannel: ->
    self = @
    AppCable.claimed_reward_approval = AppCable.cable.subscriptions.create "ClaimedRewardApprovalChannel" ,
      connected: ->
        console.log "Connected To Claimed Reward Approval Channel"

      disconnected: ->
        console.log "Disconnected From Claimed Reward Approval Channel"

      received: (data) ->
        self._handleClaimedRewardStatus(data["id"], data["status"])

  _handleClaimedRewardStatus: (id, status) ->
    icon_reload = "<i class='fa fa-refresh'></i>"
    btn_reload_page = "<button class='btn btn-default' onClick='window.location.reload()'>"+icon_reload+" Reload Page</button>"

    if id == @receipt_id
      if status == "approved"
        $('#claimed-reward-data').html "<span style='margin-right: 10px'>Claimed reward has been successfully approved!</span>"+btn_reload_page

      else if status == "rejected"
        $('#claimed-reward-data').html "<span style='margin-right: 10px'>Claimed reward has been successfully rejected!</span>"+btn_reload_page

      else
        $('#claimed-reward-data').html "<span style='margin-right: 10px'>Error Claimed reward Status!</span>"+btn_reload_page