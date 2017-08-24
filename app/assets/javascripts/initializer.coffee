Codingate.Initializer =
  exec: (pageName) ->
    if pageName && CustomerLoyalty[pageName]
      CustomerLoyalty[pageName]['init']()

  currentPage: ->
    return '' unless $('body').attr('id')

    bodyIds     = $('body').attr('id').split('_')
    pageName    = ''
    for bodyId in bodyIds
      pageName += CustomerLoyalty.Util.capitalize(bodyId)
    pageName

  init: ->
    CustomerLoyalty.Initializer.exec('Common')
    if @currentPage()
      CustomerLoyalty.Initializer.exec(@currentPage())

$(document).on 'ready page:load', ->
  CustomerLoyalty.Initializer.init()
