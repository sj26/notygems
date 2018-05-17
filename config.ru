require "bundler/setup"
require "rack/sendfile"

$: << File.join(__dir__, "lib")
require "notygems"

use Rack::Sendfile
run Notygems::Web
