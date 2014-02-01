Templater::Application.routes.draw do
  resources :users
  resources :sql_templates

  get "cms/*page", to: "cms#respond"
end
