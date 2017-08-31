Codingate.StoresShow =
  init: ->
    @_showMap()

  _showMap: ->

    mapElement = $('#show-map').get(0)

    latValue = $('#lat_value').val()
    longValue = $('#long_value').val()

    alert longValue
    lat_lng = new (google.maps.LatLng)(latValue, longValue)

    map = new (google.maps.Map)(mapElement,
      zoom: 13
      center: lat_lng)

    marker = new (google.maps.Marker)(
      position: lat_lng
      map: map)