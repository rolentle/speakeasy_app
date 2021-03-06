#= require json2
#= require jquery
#= require spine
#= require spine/manager
#= require spine/ajax
#= require spine/route
#= require spine/relation

#= require_tree ./lib
#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views

$ = jQuery.sub()

class App extends Spine.Controller
  @extend(Spine.Events)

  elements:
    "#messages": "messagesEl"
    ".lobby": "sidebarEl"
    "#online": "onlineEl"
    ".invites": "invitesEl"
    "#room-info": "roomInfoEl"
    "#room_search": 'searchEl'
    '#github_activity': 'githubEl'

  constructor: ->
    super
    
    # Initialize controllers:
    #  @append(@items = new App.Items)
    #  ...
    @online = new Online({ el: @onlineEl })
    @sidebar = new Sidebar({el: @sidebarEl})
    @messages = new Messages({el: @messagesEl})
    @room_info = new RoomInfo({el: @roomInfoEl})
    @search = new Search({ el: @searchEl})
    @github = new GitHub({el: @githubEl})

    # Spine.Route.setup

window.App = App