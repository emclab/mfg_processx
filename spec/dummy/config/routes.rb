Rails.application.routes.draw do

  mount MfgProcessx::Engine => "/mfg_processx"
  mount Authentify::Engine => "/authentify"
  mount Commonx::Engine => "/commonx"
  mount JobshopRfqx::Engine => '/jobshop_rfqx'
  mount Kustomerx::Engine => '/kustomerx'
  
  resource :session
  
  root :to => "authentify::sessions#new"
  match '/signin',  :to => 'authentify::sessions#new'
  match '/signout', :to => 'authentify::sessions#destroy'
  match '/user_menus', :to => 'user_menus#index'
  match '/view_handler', :to => 'authentify::application#view_handler'
end
