Eileenwold::Application.routes.draw do
  get "/galleries" => "galleries#index", as: 'galleries'
  get "/galleries/:name" => "galleries#how", as: 'gallery'
  root :to => "application#index"
end
