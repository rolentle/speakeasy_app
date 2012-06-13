$ = jQuery.sub()

class RoomInfo extends Spine.Controller

  events:
    "click #hey" : "crap"

  crap: =>
    alert "crap!"

  constructor: ->
    super
    Sidebar.bind 'joinedRoom', @fetch_room_info

  fetch_room_info: (room_id) =>
    $.get "/api/core/rooms/#{room_id}", (data) =>
      @render(data)

  save: ->
    console.log "something"

  render: (room) =>
    $("#room-info").empty()
    if room.owner
      $("#room-info").append(@admin_template(room))
      @modal = new RoomModal(el: $("#editRoom"))
    else
      $("#room-info").append(@template(room))

  template: (room) =>
    @view('rooms/info')(room: room)

  admin_template: (room) =>
    @view('rooms/admin_info')(room: room)

class RoomModal extends Spine.Controller

  elements:
    ".modal-header" : "header"

  events:
    "click": "save"

  constructor: ->
    super
    console.log @el

  save: =>
    alert "saving"

window.RoomInfo = RoomInfo