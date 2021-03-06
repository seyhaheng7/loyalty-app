Codingate.CustomerLocationsIndex =
  init: ->
    @_initMap()
    @_getCustomerLocation()
    @_subcribedChannelLocation()

  _initMap: ->
    lat_lng = new (google.maps.LatLng)(11.5449, 104.8922)
    mapOptions =
      zoom: 10
      center: lat_lng
      mapTypeId: 'roadmap'

    mapElement = $('#map_canvas').get(0)
    @map = new (google.maps.Map)(mapElement, mapOptions)
    @map.setTilt 45
    @markers = []

  _getCustomerLocation: ->
    self = @
    $.ajax
      url: window.location.href + '.json'
      dataType: 'json'
      success: (customers) ->
        if customers.length > 0
          self._addMarkers(customers)
          self._fitBonds(customers)

  _addMarkers: (customers)->
    for customer in customers
      position = new (google.maps.LatLng)(customer.lat, customer.long)
      @_addCustomerToMap(customer)

  _fitBonds: (customers)->
    bounds = new (google.maps.LatLngBounds)
    for customer in customers
      position = new (google.maps.LatLng)(customer.lat, customer.long)
      bounds.extend position
    @map.fitBounds bounds

  _addCustomerToMap: (customer)->
    self = @


    position = new (google.maps.LatLng)(customer.lat, customer.long)

    marker = new (google.maps.Marker)(
      position: position
      map: @map
      customer: customer)

    @markers[customer.id] = marker

    content = self._contentofInforWindow(customer)

    self._showInfoWindowofMarker(marker, content)
    self._hideWhenCustomerInactive(customer)


  _hideWhenCustomerInactive: (customer)->
    self = @
    setTimeout ->
      self._removeCustomerMarker(customer) if self._isUpdateMoreThan30Minutes(customer)
    , 2*60*1000

  _contentofInforWindow: (customer)->
    avatar_size = "style = 'height: 83px; width: 83px;'"
    customer_avatar = "<img src = '"+customer.avatar.url+"' "+avatar_size+"><br>"

    customer_name = "<div style='margin:7px;'>"+customer.first_name+" "+customer.last_name+""
    customer_phone = customer.phone+"</div>"

    customer_url = "/customers/"+customer.id+"<br>"
    class_btn = "btn btn-primary btn-sm"
    icon_btn = "<i class = 'fa fa-info-circle'></i>"
    customer_info_link = "<a href='"+customer_url+"' class= '"+class_btn+"'>"+icon_btn+" User Info</a>"

    content = customer_avatar+customer_name+customer_phone+customer_info_link

  _showInfoWindowofMarker: (marker, content)->
    self = @
    infowindow = new (google.maps.InfoWindow)(content: content)
    marker.addListener 'click', ->
      infowindow.open @map, marker
    self._initClickOnMapListner(infowindow)

  _initClickOnMapListner: (infowindow)->
    google.maps.event.addListener @map, 'click', (event) ->
      infowindow.close()

  _isUpdateMoreThan30Minutes: (customer)->
    # Reload customer for data changed
    customer = self.markers[customer.id].customer

    last_update_location_date = new Date(customer.update_location_at)
    current_date = new Date()

    different_date = current_date - last_update_location_date

    # Convert Date to durations
    durations = Math.round(different_date % (24*60*60*1000) % (60*60*1000) / (60*1000))
    return durations > 2

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
