Codingate.StoresForm = Codingate.StoresNew = Codingate.StoresCreate = Codingate.StoresEdit = Codingate.StoresUpdate =
  init: ->
    @_handleAddedImage()
    @_initMap()
    @_changeMarkerPosition()

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

    @geocoder = new (google.maps.Geocoder)
    google.maps.event.addListener @marker, 'dragend', (event) ->
      lat = @getPosition().lat()
      lng = @getPosition().lng()

      latField.val lat
      longField.val lng

  _handleAddedImage: ->
    $('#store-images').on 'cocoon:after-insert', (e, added_image) ->
      uploader = $(added_image).find('.image-uploader')

      input = $(added_image).find('input[type="file"]')
      imageHolder = $(added_image).find('img')

      input.on 'change', (e)->
        reader = new FileReader
        reader.onload = (e)->
          imageHolder.attr('src', e.target.result)

        file = @files[0]
        reader.readAsDataURL file

      imageHolder.click ->
        input.click()

  _changeMarkerPosition: ->
    self = @
    lat = $('#place_latitude')
    lng = $('#place_longitude')
    address = $('#store_address')

    lat.change ->
      self._handleLatLngChange(lat.val(), lng.val())

    lng.change ->
      self._handleLatLngChange(lat.val(), lng.val())

    address.change ->
      self._handleAddressChange(address.val())

  _handleLatLngChange: (lat, lng)->
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
    @map.setZoom 16

  _handleAddressChange: (address)->
    self = @
    loading = @._initLoadingSpan()
    @geocoder.geocode { 'address': address }, (results, status) ->
      if status == 'OK'
        lat = results[0].geometry.location.lat()
        lng = results[0].geometry.location.lng()
        self._setValueToInputLatLng(lat, lng)
        self._handleLatLngChange(lat, lng)
        loading.css 'display', 'none'

      else if status == "ZERO_RESULTS"
        loading["message"].text 'Lat-Long not found for Address!'
        loading["image"].css 'display', 'none'
      else
        loading["message"].text status
        loading["image"].css 'display', 'none'

  _initLoadingSpan: ->
    loading = $("#loading")
    loading["image"] = $("#loading_image")
    loading["image"].css 'display', 'block'
    loading["message"] = $("#loading_message")
    loading["message"].text "Loading..."
    loading.css 'display', 'block'

    return loading

  _setValueToInputLatLng: (lat, lng)->
    $('#place_latitude').val lat
    $('#place_longitude').val lng
