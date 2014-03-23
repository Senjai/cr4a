module Handlers
  class Railtie < Rails::Railtie
    config.app_generators.mailer template_engine: :merb
  end
end
