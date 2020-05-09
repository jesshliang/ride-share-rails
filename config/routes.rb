Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homepages#index'
<<<<<<< HEAD

  resources :trips

=======
  resources :trips, except: [:index, :new]
>>>>>>> Trips
  resources :passengers

  resources :drivers do
    resources :trips, only: [:show, :new]
  end
end
