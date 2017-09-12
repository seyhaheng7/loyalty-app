Codingate.CustomerLocationsIndex =
  init: ->
    @_initMap()
    @_getCustomerLocation()
    @_subcribedChannelLocation()

  _initMap: ->
    mapOptions = mapTypeId: 'roadmap'
    mapElement = $('#map_canvas').get(0)
    @map = new (google.maps.Map)(mapElement, mapOptions)
    @map.setTilt 45
    @markers = []

  _getCustomerLocation: ->
    self = @
    # Get Customers Informations
    $.ajax
      url: '/customer_locations.json'
      dataType: 'json'
      success: (customers) ->
        self._addMarkers(customers)
        self._fitBonds(customers)

  _fitBonds: (customers)->
    bounds = new (google.maps.LatLngBounds)
    for customer in customers
      position = new (google.maps.LatLng)(customer.lat, customer.long)
      bounds.extend position
    @map.fitBounds bounds

  _addMarkers: (customers)->
    for customer in customers
      position = new (google.maps.LatLng)(customer.lat, customer.long)
      @_addCustomerToMap(customer)

  _addCustomerToMap: (customer)->
    self = @
    position = new (google.maps.LatLng)(customer.lat, customer.long)    
    marker = new (google.maps.Marker)(
      position: position
      map: @map
      customer: customer)
    @markers[customer.id] = marker

    self._hideWhenCustomerInactive(customer)

  _hideWhenCustomerInactive: (customer)->
    self = @
    setTimeout ->
      self._removeCustomerMarker(customer) if self._isUpdateMoreThan30Minutes(customer)        
    , 30*60*1000

  _isUpdateMoreThan30Minutes: (customer)->
    # Reload customer for data changed
    customer = self.markers[customer.id].customer
        
    last_update_location_date = new Date(customer.update_location_at)
    current_date = new Date()

    different_date = current_date - last_update_location_date

    durations = Math.round(different_date % (24*60*60*1000) % (60*60*1000) / (60*1000))
    return durations > 30

  _updateCustomerOnMap: (customer)->
    @_removeCustomerMarker(customer)
    @_addCustomerToMap(customer)

  _removeCustomerMarker: (customer)->
    if @markers[customer.id] != undefined
      @markers[customer.id].setMap null

  _subcribedChannelLocation: ->

    self = @

    AppCable.customer = AppCable.cable.subscriptions.create 'CustomerLocationChannel', 
      connected: ->
        console.log "Connected To Customer Locations Channel"

      disconnected: ->
        console.log "Disconnected From Customer Locations Channel"

      received: (data) ->
        self._updateCustomerOnMap(data['customer'])
