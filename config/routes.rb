Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    post :sign_in, to: 'auth#sign_in'
    post :sign_out, to: 'auth#sign_out'

    resources :users, only: [:create]

    resources :students, except: [:destroy] do

      get :family_members, to: 'students#family_members'
      resources :family_members, only: [:create, :update]

      get :type_scholarships, to: 'students#type_scholarships'

      get :payment_methods, to: 'students#payment_methods'

      get :comments, to: 'students#comments'

      resources :comments, only: [:create, :update]

      get :discounts, to: 'students#discounts'
      resources :discounts, only: [:create, :update]

    end
    
    resources :type_scholarships, only: [:index, :update]
    resources :student_type_scholarships, only: [:create, :update]


    resources :payment_methods, except: [:delete]
    resources :student_payment_methods, only: [:create, :update]

  end
end
