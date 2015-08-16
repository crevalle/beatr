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

var debug = function debug(data) {
  console.log('channel event received: ' + data);
}


dispatcher = new WebSocketRails('localhost:3000/websocket');

var channelName = window.location.pathname.slice(1); // remove leading slash
console.log(channelName);

var channel = dispatcher.subscribe(channelName);

dispatcher.on_open = function(data) {
  console.log('Connection has been established: ', data);
}

channel.bind('heartbeat', debug)

