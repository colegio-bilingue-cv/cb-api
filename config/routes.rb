Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  namespace :api do
    resources :students, except: [:destroy] do
      get :family_members, to: 'students#family_members'
      resources :family_members, only: [:create, :update]
      get :type_scholarships, to: 'students#type_scholarships'
    end
    resources :type_scholarships, only: [:index]
    resources :students_type_scholarships, only: [:create]

  end
end
