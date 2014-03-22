require 'action_view/template'

ActionView::Template.register_template_handler :rb,
  ->(template) { template.source }

module Handlers
end
