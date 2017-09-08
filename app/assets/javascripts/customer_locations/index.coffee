Codingate.CustomerLocationsIndex =
  init: ->
    @_initMap()
    @_getCustomerLocation()

  _initMap: ->
    mapOptions = mapTypeId: 'roadmap'
    mapElement = $('#map_canvas').get(0)
    @map = new (google.maps.Map)(mapElement, mapOptions)
    @map.setTilt 45

    @bounds = new (google.maps.LatLngBounds)

  _getCustomerLocation: ->
    self = @
    # Get Customers Informations
    $.ajax
      url: '/customer_locations.json'
      dataType: 'json'
      success: (customers) ->
        self._addCustomersToMap(customers)

  _addCustomersToMap: (customers)->

    self = @

    for customer in customers
      position = new (google.maps.LatLng)(customer.lat, customer.long)
      @bounds.extend position
      marker = new (google.maps.Marker)(
        position: position
        map: @map
        title: customer.name)

    @map.fitBounds @bounds
