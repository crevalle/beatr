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

App.beats = App.cable.subscriptions.create { channel: 'BeatsChannel', topic: "#{Beatr.topicName()}" },
  connected: ->

  countSpan: -> $('span.subscriber-count')
  recentBeatsCountSpan: -> $('span.recent-beats-count')

  updateSubscriberCount: (count) ->
    @countSpan().html count

  updateRecentBeatsCount: (count) ->
    @recentBeatsCountSpan().html count

  received: (data) ->
    if data.type == 'beat'
      @updateSubscriberCount(data.subscribers.count)
      @updateRecentBeatsCount(data.recent_beats)
      Beatr.beats += 1
      if Beatr.resting
        Beatr.beat()



$(document).ready ->

  Beatr.heart = $('#heart')
  Beatr.heart.click ->
    $.post(@path)

  LittleBeatr.heart = $('#tiny-heart')
  LittleBeatr.beat()

