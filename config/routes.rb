Parsels::Application.routes.draw do
  resources :shipments
  root to: 'shipments#index'
end
