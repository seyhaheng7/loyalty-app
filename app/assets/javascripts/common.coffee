Codingate.Common =
  init: ->
    @_initImageUploader()
    @_initSelect2()
    @_initDataGrid()
    @_handleNotificationsToggleClicked()

  _handleNotificationsToggleClicked: ->
    $('#notifications-toggle').click ->
      $('#pending-notifications-count').hide()
      $.getScript('/notifications/top_nav.js')

  _initDataGrid: ->
    $('.date_filter').datepicker
      format: 'yyyy-mm-dd'

  _initImageUploader: ->
    $.each $('.image-uploader'), (index, uploader)->
      uploader = $(uploader)
      input = uploader.find('input[type="file"]')
      imageHolder = uploader.find('img')

      input.on 'change', (e)->
        reader = new FileReader
        reader.onload = (e)->
          imageHolder.attr('src', e.target.result)

        file = @files[0]
        reader.readAsDataURL file

      imageHolder.click ->
        input.click()

  _initSelect2: ->
    $('select').select2 theme: 'bootstrap'

