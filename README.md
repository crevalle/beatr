# Beatr.io

Add heartbeats to anything.


This is a demo app exploring Rails' new ActionCable library.  It is not optimized and will probably break under heavy usage, but it's still a good time.


## Getting Started

Visit any url at http://beatr.io, such as http://beatr.io/crevalle or http://beatr.io/desmond, and you'll see a heart.  Whenever
you send a POST request to that same URL, the heart will beat.  Pretty Cool.  It's designed for small companies and organizations that want a more human, visceral connection to how
their application is doing instead of soulless performance metrics or pageviews.  Use it for user signups, customer conversions,
postive reviews left, or whatever.

There's also a companion Ruby gem for simplifying the process of sending Beats.  Simply add `gem 'beatr', '~> 0.1'` to your Gemfile
and call `Beatr.beat '<your-route>'` anywhere in your code.  More instructions found at https://github.com/crevalle/beatr-client.


---

© 2015 Crevalle Technologies, LLC.  :heart::heart::heart:
