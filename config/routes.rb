Rails.application.routes.draw do

  resources :transactions

  resources :exclusions

  resources :banks

  put '/recurrence/:id/advance' => 'recurrences#update', :as => 'advance_recurrence'
  resources :recurrences

  resources :bills

  resources :accounts

  get 'demo' => 'welcome#demo'

  get 'help' => 'help#index'
  post 'help/:id' => 'help#show', as: 'view_user'
  delete "help/:id" => "help#revert_show", as: 'revert_view_user'
  
  devise_for :users
  
  get 'dashboard' => 'dashboard#index'
  post 'skip_payment' => 'dashboard#skip_payment'
  post 'mark_paid' => 'dashboard#mark_paid'

  # You can have the root of your site routed with "root"
  root 'welcome#index'

end
