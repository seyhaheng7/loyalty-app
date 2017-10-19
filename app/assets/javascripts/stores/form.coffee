Codingate.StoresForm = Codingate.StoresNew = Codingate.StoresCreate = Codingate.StoresEdit = Codingate.StoresUpdate =
  init: ->
    @_initMap()
    @_phoneMask()
    @_changeMarkerPosition()

  _phoneMask: ->
    $('#store_phone').inputmask '999-999-9999'
    $('form').submit ->
      $('#store_phone').inputmask('remove')

  _initMap: ->
    self = @
    DEFAULT_LATITUDE = 11.570436366295361
    DEFAULT_LONGITUDE = 104.87980718085987

    mapElement = $('#map').get(0)

    latField = $('#place_latitude')
    longField = $('#place_longitude')

    if latField.val() == '' || longField.val() == ''
      latField.val DEFAULT_LATITUDE
      longField.val DEFAULT_LONGITUDE

    lat_lng = new (google.maps.LatLng)(latField.val(), longField.val())

    @map = new (google.maps.Map)(mapElement,
    zoom: 16
    center: lat_lng)

    @marker = new (google.maps.Marker)(
      map: self.map
      draggable: true
      animation: google.maps.Animation.DROP
      position: lat_lng)

    google.maps.event.addListener @marker, 'dragend', (event) ->

      lat = @getPosition().lat()
      lng = @getPosition().lng()

      latField.val lat
      longField.val lng

  _changeMarkerPosition: ->    
    self = @
    lat = $('#place_latitude')
    lng = $('#place_longitude')

    lat.change ->
      self._handleLatLngChange(lat.val(), lng.val())
    
    lng.change ->
      self._handleLatLngChange(lat.val(), lng.val())

  _handleLatLngChange: (lat, lng) ->
    lat_lng = @._latLngChange(lat, lng) 
    @marker.setMap null
    @._updateMarker(lat_lng)
    @._fitBounds(lat, lng)

  _latLngChange: (lat, lng) ->
    lat_lng = new (google.maps.LatLng)(lat, lng)

  _updateMarker: (lat_lng)->
    self = @
    @marker = new (google.maps.Marker)(
      map: self.map
      draggable: true
      animation: google.maps.Animation.DROP
      position: lat_lng)

  _fitBounds: (lat, lng) ->
    bounds = new (google.maps.LatLngBounds)
    position = new (google.maps.LatLng)(lat, lng)
    bounds.extend position
    @map.fitBounds bounds
    @map.setZoom 10
  
  
  
  