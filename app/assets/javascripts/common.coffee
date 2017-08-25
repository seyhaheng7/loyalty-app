Codingate.Common =
  init: ->
    @_initImageUploader()

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
