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
      resources :comments, only: [:create]

      get 'activate', to: 'students#activate'
    end
    resources :type_scholarships, only: [:index]
    resources :student_type_scholarships, only: [:create]


    resources :payment_methods, only: [:create, :index, :show]
    resources :student_payment_methods, only: [:create]

    resources :cicles, only: [:index, :show] do
      resources :questions, only: [:index]
    end
    
    resources :groups, except: [:show] 
    #exepc[:create, :index, :destroy]
  end
end
