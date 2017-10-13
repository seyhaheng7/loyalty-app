Codingate.StoresForm = Codingate.StoresNew = Codingate.StoresCreate = Codingate.StoresEdit = Codingate.StoresUpdate =
  init: ->
    @_initMap()
    @_phoneMask()

  _phoneMask: ->
    $('#store_phone').inputmask '999-999-9999'
    $('form').submit ->
      $('#store_phone').inputmask('remove')

  _initMap: ->
    DEFAULT_LATITUDE = 11.570436366295361
    DEFAULT_LONGITUDE = 104.87980718085987

    mapElement = $('#map').get(0)

    latField = $('#place_latitude')
    longField = $('#place_longitude')

    if latField.val() == '' || longField.val() == ''
      latField.val DEFAULT_LATITUDE
      longField.val DEFAULT_LONGITUDE

    lat_lng = new (google.maps.LatLng)(latField.val(), longField.val())

    map = new (google.maps.Map)(mapElement,
    zoom: 16
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
