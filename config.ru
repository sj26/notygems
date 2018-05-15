require "rubygems"
require "bundler/setup"
require "sinatra/base"

# Just enough Rubygems to gem install with speed
class Notygems < Sinatra::Base
  set :show_exceptions, true

  # Gem names have at least one letter somewhere, and some other safe chars
  NAME_PATTERN = /\A(?=[A-Za-z])[A-Za-z0-9\._-]+\Z/

  mime_type "marshal", "application/x-ruby-marshal"

  get "/" do
    send_data "public/index.html"
  end

  # `gem install ...` hits this to see if we have an API, so just say "yes"
  # really quickly with a successful response
  head "/api/v1/dependencies" do
    halt :no_content
  end

  # `gem install ...` asks this for gem versions and their dependencies
  get %r{/api/v1/dependencies(?:\.(?<format>json|marshal))?}, provides: [:marshal, :json] do
    names = params.fetch(:gems, "").split(",")
    unless names.all? { |name| name.match?(NAME_PATTERN) }
      halt :unprocessible_entity # no funny stuff
    end

    # Allow format extension to override content type
    # (Hint: http://gems.railscamp.local/api/v1/dependencies.json?gems=rails is much nicer to debug)
    content_type params[:format] unless params[:format].nil?

    # We've generate an index of dependencies, marshalled like the quick index
    deps = names.map do |name|
      File.join("public", "dependencies", "Marshal.4.8", "#{name}.gemdeps.rz")
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

run Notygems
