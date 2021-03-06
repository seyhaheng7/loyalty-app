Codingate.CustomersForm = Codingate.CustomersNew = Codingate.CustomersCreate = Codingate.CustomersEdit = Codingate.CustomersUpdate =
  init: ->
    @_phoneMask()
    @_initCustomerMap()

  _phoneMask: ->
    $('#customer_phone').inputmask '999-999-9999'
    $('form').submit ->
      $('#customer_phone').inputmask('remove')

  _initCustomerMap: ->
    DEFAULT_LATITUDE = 11.570436366295361
    DEFAULT_LONGITUDE = 104.87980718085987

    mapElement = $('#map-customer').get(0)

    latField = $('#customer_lat')
    longField = $('#customer_long')

    if latField.val() == '' || longField.val() == ''
      latField.val DEFAULT_LATITUDE
      longField.val DEFAULT_LONGITUDE

    lat_lng = new (google.maps.LatLng)(latField.val(), longField.val())

    map = new (google.maps.Map)(mapElement,
    zoom: 13
    center: lat_lng)

    marker = new (google.maps.Marker)(
      map: map
      draggable: true
      animation: google.maps.Animation.DROP
      position: lat_lng)

    google.maps.event.addListener marker, 'dragend', (event) ->

      lat = @getPosition().lat()
      lng = @getPosition().lng()

      latField.val lat
      longField.val lng

