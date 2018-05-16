require "rubygems"
require "bundler/setup"

$: << File.join(__dir__, "lib")
require "notygems"

run Notygems::Web
