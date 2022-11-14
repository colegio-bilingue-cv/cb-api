Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    post :sign_in, to: 'auth#sign_in'
    post :sign_out, to: 'auth#sign_out'

    resources :users, except: [:delete] do
      post :documents, to: 'users#create_document'
      post :complementary_informations, to: 'users#create_complementary_information'
      post :absences, to: 'users#create_absence'
      delete 'absences/:id', to: 'users#destroy_absence'
      delete 'documents/:id', to: 'users#destroy_document'
      delete 'complementary_informations/:id', to:'users#destroy_complementary_information'
    end

    scope :students, controller: :students do
      get :active
      get :inactive
      get :pending
    end

    resources :students, except: [:destroy] do
      resources :answers, only: [:create, :update]
      resources :comments, only: [:create, :update, :destroy]
      resources :discounts, only: [:create, :update, :destroy]
      resources :family_members, only: [:create, :update]

      resources :final_evaluations, only: [:create, :update, :destroy]
      resources :intermediate_evaluations, only: [:create, :update, :destroy]
      resources :relevant_events, only: [:create, :update, :destroy]

      get :answers
      get :comments
      get :discounts
      get :evaluations
      get :family_members
      get :payment_methods
      get :relevant_events
      get :type_scholarships

      post :activate
      post :deactivate
    end

    resources :type_scholarships, only: [:create, :index, :update, :destroy]
    resources :student_type_scholarships, only: [:create, :update, :destroy]

    resources :payment_methods, except: [:delete]
    resources :student_payment_methods, only: [:create, :update, :destroy]
    resources :cicles, only: [:index]

    resources :groups, only: [:index] do
      get :teachers
      get :students
    end

    resources :grades, only: [:index, :show] do
      resources :groups, only: [:create, :update]
    end

    resource :me, only: [:show, :update], controller: :me do
      patch :password
      post :documents, to:'me#create_document'
      post :complementary_informations, to: 'me#create_complementary_information'
      post :absences, to: 'me#create_absence'
      get :groups
      get :teachers
      get :students, to: 'me#groups_students'

      delete 'absences/:id', to:'me#destroy_absence'
      delete 'documents/:id', to:'me#destroy_document'
      delete 'complementary_informations/:id', to: 'me#destroy_complementary_information'

      scope :groups, controller: :me do
        get :students
      end
    end

    resources :teachers, only: [:index]
    resources :support_teachers, only: [:index]
    resources :principals, only: [:index]

    resource :user_groups, only: [:create, :destroy]
  end
end
