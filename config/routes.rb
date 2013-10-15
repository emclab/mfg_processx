MfgProcessx::Engine.routes.draw do
  resources :mfg_processes do
    resources :process_steps
    collection do
      get :search
      put :search_results      
      get :stats
      put :stats_results
    end      
  end
  

  root :to => 'mfg_processes#index'
end
