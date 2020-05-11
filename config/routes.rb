Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homepages#index'
  
  resources :trips, except: [:index]

  resources :passengers do
    resources :trips, only: [:create]
  end

  resources :drivers do
    resources :trips, only: [:show, :new]
  end

  #get '/trips/:id/rate', to: 'trips#rate', as: 'rate'
  patch '/drivers/:id/available', to: 'drivers#set_available', as: 'toggle_avail'
end
