Codingate.MerchantsForm = Codingate.MerchantsNew = Codingate.MerchantsCreate = Codingate.MerchantsEdit = Codingate.MerchantsUpdate =
  init: ->
    @_phoneMask()

  _phoneMask: ->
    $('#merchant_phone').inputmask '999-999-9999'
    $('form').submit ->
      $('#merchant_phone').inputmask('remove')
