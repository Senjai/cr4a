require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)
require "handlers"

module Dummy
  class Application < Rails::Application
    config.generators.mailer template_engine: :merb
  end
end

