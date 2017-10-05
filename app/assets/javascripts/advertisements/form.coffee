Codingate.AdvertisementsForm = Codingate.AdvertisementsNew = Codingate.AdvertisementsCreate = Codingate.AdvertisementsEdit = Codingate.AdvertisementsUpdate =
  init: ->
    @_initAdvertisementMap()

  _initAdvertisementMap: ->
    DEFAULT_LATITUDE = 11.570436366295361
    DEFAULT_LONGITUDE = 104.87980718085987

    mapElement = $('#map-advertisement').get(0)

    latField = $('#advertisement_lat')
    longField = $('#advertisement_long')

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

