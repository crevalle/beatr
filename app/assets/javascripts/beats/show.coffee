#= require cable
#= require_self
#= require_tree .

@App = {}
String::capitalize = -> @charAt(0).toUpperCase() + @slice(1)

@path = window.location.pathname

App.cable = Cable.createConsumer gon.websocket_url

Beatr =
  resting: true,
  beats: 0,
  animationTime: 250,
  beat: (callback) ->
    Beatr.resting = false
    Beatr.grow()

  topicName: =>
    return decodeURI(@path.slice(1)).replace(/ /g, '-')

  grow: =>
    Beatr.heart.addClass('beat')
    setTimeout(Beatr.shrink, Beatr.animationTime)

  shrink: =>
    Beatr.heart.removeClass('beat')
    setTimeout(Beatr.afterBeat, Beatr.animationTime)

  afterBeat: =>
    Beatr.beats -= 1
    if Beatr.beats > 0
      Beatr.beat()
    else
      Beatr.resting = true


LittleBeatr =
  animationTime: 1000,
  beat: (callback) ->
    LittleBeatr.grow()

  grow: =>
    LittleBeatr.heart.addClass('beat')
    setTimeout(LittleBeatr.shrink, LittleBeatr.animationTime)

  shrink: =>
    LittleBeatr.heart.removeClass('beat')
    setTimeout(LittleBeatr.afterBeat, LittleBeatr.animationTime)

  afterBeat: =>
    LittleBeatr.beat()

App.beats = App.cable.subscriptions.create 'BeatsChannel',
  connected: ->
    console.log ("connected to #{gon.websocket_url}")
    @follow("#{Beatr.topicName()}")
    console.log ("following #{Beatr.topicName()}")

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

  LittleBeatr.heart = $('#tiny-heart')
  LittleBeatr.beat()



