@path = window.location.pathname
@animationTime = 250

Beatr =
  resting: true,
  beats: 0,
  beat: (callback) ->
    Beatr.resting = false
    Beatr.grow()

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
  received: (data) ->
    console.log data
    Beatr.beats += 1
    if Beatr.resting
      Beatr.beat()

$(document).ready ->
  Beatr.heart = $('#heart')

  Beatr.heart.click ->
    $.post(@path)


