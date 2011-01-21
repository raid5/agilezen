require "bundler"
Bundler.setup

require "rspec"
require "agilezen"
require "support/matchers"

Rspec.configure do |config|
  config.include AgileZen::Spec::Matchers
end