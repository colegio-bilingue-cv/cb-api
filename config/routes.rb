Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    post :sign_in, to: 'auth#sign_in'
    post :sign_out, to: 'auth#sign_out'

    resources :users, only: [:create, :update, :index]

    scope :students, controller: :students do
      get :active
      get :inactive
      get :pending
    end

    resources :students, except: [:destroy] do
      resources :family_members, only: [:create, :update]
      resources :comments, only: [:create, :update]
      resources :final_evaluation, only: [:create, :update]
      resources :intermediate_evaluation, only: [:create, :update]

      get :family_members
      get :type_scholarships
      get :payment_methods
      get :comments
      get :discounts
      get :evaluations

      resources :discounts, only: [:create, :update]
      post :activate
      post :deactivate
    end

    resources :type_scholarships, only: [:create, :index, :update]
    resources :student_type_scholarships, only: [:create, :update]

    resources :payment_methods, except: [:delete]
    resources :student_payment_methods, only: [:create, :update]
    resources :cicles, only: [:index]

    resources :groups, only: [:index]
    resources :grades, only: [:index, :show] do
      resources :groups, only: [:create, :update]
    end

    resource :me, only: [:show, :update], controller: :me do
      patch :password
      post :documents, to:'me#create_document'
      post :complementary_informations, to: 'me#create_complementary_information'
      post :absences, to: 'me#create_absence'
    end

    resources :teachers, only: [:index]
  end
end
