# frozen_string_literal: true

Rails.application.routes.draw do
  resources :transactions

  resources :exclusions

  resources :banks

  put '/recurrence/:id/advance' => 'recurrences#advance', :as => 'advance_recurrence'
  resources :recurrences

  resources :bills

  resources :accounts

  devise_for :users, controllers: { registrations: "users/registrations" }

  get 'dashboard' => 'dashboard#index'
  get 'dashboard_chart' => 'dashboard#chart'
  post 'skip_payment' => 'dashboard#skip_payment'
  post 'mark_paid' => 'dashboard#mark_paid'
  post 'generate_examples' => 'dashboard#generate_examples'

  get 'contact' => 'contact#index'
  post 'contact' => 'contact#create'

  root 'welcome#landing'
end
