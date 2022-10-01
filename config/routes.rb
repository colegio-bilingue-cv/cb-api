Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  namespace :api do
    resources :students, except: [:destroy] do

      get :family_members, to: 'students#family_members'
      resources :family_members, only: [:create, :update]

      get :type_scholarships, to: 'students#type_scholarships'

      get :payment_methods, to: 'students#payment_methods'

      get :comments, to: 'students#comments'
      resources :comments, only: [:create]

    end
    resources :type_scholarships, only: [:index]
    resources :student_type_scholarships, only: [:create]


    resources :payment_methods, only: [:create, :index, :show]
    resources :student_payment_methods, only: [:create]
   
  end
end
