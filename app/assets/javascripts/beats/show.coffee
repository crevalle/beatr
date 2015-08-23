#= require cable
#= require_self
#= require_tree .

@App = {}
String::capitalize = -> @charAt(0).toUpperCase() + @slice(1)

@path = window.location.pathname
@animationTime = 250

# App.cable = Cable.createConsumer "ws://localhost:3013#{@path}"
App.cable = Cable.createConsumer "ws://localhost:3013"

Beatr =
  resting: true,
  beats: 0,
  beat: (callback) ->
    Beatr.resting = false
    Beatr.grow()

  topicName: =>
    return decodeURI(@path.slice(1)).replace(/ /g, '-')

  grow: =>
    Beatr.heart.addClass('beat')
    setTimeout(Beatr.shrink, @animationTime)

  shrink: =>
    Beatr.heart.removeClass('beat')
    setTimeout(Beatr.afterBeat, @animationTime)

  afterBeat: =>
    Beatr.beats -= 1
    if Beatr.beats > 0
      Beatr.beat()
    else
      Beatr.resting = true



App.beats = App.cable.subscriptions.create 'BeatsChannel',
  connected: ->
    @follow("#{Beatr.topicName()}")

  received: (data) ->
    console.log data
    Beatr.beats += 1
    if Beatr.resting
      Beatr.beat()

  follow: (topic) ->
    @perform 'follow', topic: topic


$(document).ready ->

  Beatr.heart = $('#heart')

  Beatr.heart.click ->
    $.post(@path)

