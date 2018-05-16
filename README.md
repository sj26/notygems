# Not-quite Rubygems

Just enough [Rubygems](https://github.com/rubygems/rubygems) to `gem install` quickly, without the Internet.

The [Rubygems registry](https://github.com/rubygems/rubygems.org) is a great big app which is pretty specifically built to serve https://rubygems.org. Most solutions which can do gem mirroring try to do too much, are slightly broken, and none have the [dependencies api](https://github.com/rubygems/rubygems.org/blob/master/app/controllers/api/v1/dependencies_controller.rb) (originally the [bundler api](https://github.com/bundler/bundler-api)). This project mirrors the gem spec lists, all ruby gem packages so they can served as files directly, and implements both the quick index and the dependencies api. It is intended to provide a complete offline read-only mirror of Rubygems.

## Updating the mirror

You'll need [aria2c](https://aria2.github.io) installed — it lets us download http packages really quickly and with concurrency.

Try:

```
bin/mirror
```

Then you'll need to rebuild the indexes:

```
bin/quick_index
bin/dependencies_index
```

## Running

The application is built with [Ruby](http://ruby-lang.org) and [Sinatra](http://sinatrarb.com) for a [Railscamp](http://rails.camp) and can be run, after [bundling](http://bundler.io), with `rackup` or your favourite [Rack](https://rack.github.io) server (we're using [Passenger](https://www.phusionpassenger.com) at camp):

```
# Install dependencies
bundle

# Run the http server, http://localhost:3000 by default
rackup
```

Note that it expects static files from the public directory to be served directly. You can add Rack::File or something if your server doesn't handle that.
