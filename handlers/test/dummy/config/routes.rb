Dummy::Application.routes.draw do
  get "/handlers/:action", to: "handlers"
end
