class CmsController < ActionController::Metal
  include ActionController::Rendering

  prepend_view_path SqlTemplate::Resolver.instance

  def respond
    render template: params[:page]
  end
end
