Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  namespace :api do 
    resources :students, only: [:create] do
      resources :family_members, only: [:create]
    end
    
  end
end
