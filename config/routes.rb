Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  namespace :api do
    resources :students, except: [:destroy] do
      get :family_members, to: 'students#family_members'
      resources :family_members, only: [:create]
    end
  end
end
