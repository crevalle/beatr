// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require websocket_rails/main

var dispatcher = new WebSocketRails(window.location.host + ':3001/websocket');
var path = window.location.pathname;
var channelName = decodeURI(path.slice(1)).replace(/ /g, '-');
var channel = dispatcher.subscribe(channelName);
var animationTime = 250;

Beatr = {
  resting: true,
  beats: 0,
  beat: function beat(callback) {
    Beatr.resting = false;
    Beatr.grow();
  },
  grow: function grow() {
    Beatr.heart.addClass('beat');
    setTimeout(Beatr.shrink, animationTime);
  },
  shrink: function shink() {
    Beatr.heart.removeClass('beat');
    setTimeout(Beatr.afterBeat, animationTime);
  },
  afterBeat: function afterBeat() {
    Beatr.beats -= 1;
    if (Beatr.beats > 0) {
      Beatr.beat();
    } else {
      Beatr.resting = true;
    }
  }
}

$(document).ready(function () {
  Beatr.heart = $('#heart');

  Beatr.heart.click(function () {
    $.post(path);
  });

  channel.bind('heartbeat', function (data) {
    console.log(data);
    Beatr.beats += 1;
    if (Beatr.resting) {
      Beatr.beat()
    }
  });
});

