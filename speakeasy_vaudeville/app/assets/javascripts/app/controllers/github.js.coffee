$ = jQuery.sub()

class GitHub extends Spine.Controller

  constructor: ->
    super
    @render()

    GitHubEvent.bind 'create', @addOne
    Room.bind 'joined', @joinedRoom

  joinedRoom: (room_id) =>
    @clear()
    @fetch_all(room_id)

  clear: ->
    $("#github_activity").html('')

  fetch_all: (room_id) =>
    room = Room.find(room_id)
    if room.github_url
      github_url = room.github_url.replace("https://github.com/", "")

      $.ajax {
        url: "https://secure.travis-ci.org/#{github_url}.png"
        success: =>
          $("#ci_status").attr('src', "https://secure.travis-ci.org/#{github_url}.png")
          $("#travis_ci").show()
        crossDomain: true
      }
      
      $("#github_content").show()

      $.get "/api/github?url=#{room.github_url}", (data) =>
        GitHubEvent.deleteAll()
        console.log(data)
        for event in data
          GitHubEvent.create(data: event)

        @render()
    else
      $("#travis_ci").hide()
      $("#github_content").hide()

  addOne: =>
    console.log('add one')
    GitHubEvent.deleteAll()
    @clear()
    @render()

  template: ->
    @events = GitHubEvent.all()
    @view('github/activity')(@)

  render: =>
    @clear()
    $("#github_activity").html @template()

  scroll: =>
    objDiv = $("#github_activity")[0]
    objDiv.scrollTop = objDiv.scrollHeight

window.GitHub = GitHub