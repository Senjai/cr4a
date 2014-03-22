require 'action_view/template'

ActionView::Template.register_template_handler :rb, :source.to_proc

module Handlers
end
