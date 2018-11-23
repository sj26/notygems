require "sinatra/base"

module Notygems
  class Web < Sinatra::Base
    set :show_exceptions, true

    # Gem names have at least one letter somewhere, and some other safe chars
    NAME_PATTERN = /\A(?=[A-Za-z])[A-Za-z0-9\._-]+\Z/

    mime_type "marshal", "application/x-ruby-marshal"

    # `bundle update` etc use this for a fill list of available gem versions
    # and requires a valid etag which is expected to be an md5, precomputed here
    get "/versions" do
      etag File.read("db/versions.md5").chomp
      send_file "db/versions", type: "text/plain"
    end

    # `gem install ...` hits this to see if we have an API, so just say "yes"
    # really quickly with a successful response
    head "/api/v1/dependencies" do
      halt :no_content
    end

    # `gem install ...` asks this for gem versions and their dependencies
    get %r{/api/v1/dependencies(?:\.(?<format>json|marshal))?}, provides: [:marshal, :json] do
      names = params.fetch(:gems, "").split(",")
      if (bad_names = names.grep_v(NAME_PATTERN)).any?
        halt 422, {"Content-Type" => "text/plain"}, "Invalid gem names: #{bad_names.inspect}"
      end

      # Allow format extension to override content type
      # (Hint: http://gems.railscamp.local/api/v1/dependencies.json?gems=rails is much nicer to debug)
      content_type params[:format] unless params[:format].nil?

      # We've generate an index of dependencies, marshalled like the quick index
      deps = names.map do |name|
        File.join("db", "dependencies", "#{name}.gemdeps.rz")
      end.select do |path|
        File.exist? path
      end.flat_map do |path|
        Marshal.load(Gem.inflate(File.binread(path)))
      end.to_a

      if params[:format] == "json" || content_type.match?(/json/)
        JSON.generate(deps)
      else
        Marshal.dump(deps)
      end
    end
  end
end
