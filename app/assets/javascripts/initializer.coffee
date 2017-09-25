Codingate.Initializer =
  exec: (pageName) ->
    if pageName && Codingate[pageName]
      Codingate[pageName]['init']()

  currentPage: ->
    return '' unless $('body').attr('id')

    bodyIds     = $('body').attr('id').split('_')
    pageName    = ''
    for bodyId in bodyIds
      pageName += Codingate.Util.capitalize(bodyId)
    pageName

  init: ->
    Codingate.Initializer.exec('Common')
    if @currentPage()
      Codingate.Initializer.exec(@currentPage())

$(document).ready ->
  Codingate.Initializer.init()
