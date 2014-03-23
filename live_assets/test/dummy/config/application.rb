require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)
require "live_assets"

module Dummy
  class Application < Rails::Application
    config.allow_concurrency = true
  end
end

