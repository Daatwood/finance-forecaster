Rails.application.routes.draw do

  resources :transactions

  resources :exclusions

  resources :banks

  get 'recurrences/:id/advance' => 'recurrences#advance', as: 'recurrence_advance'
  resources :recurrences

  resources :bills

  resources :accounts

  #resources :messages, skip: [:new, :edit, :update]

  get 'demo' => 'welcome#demo'

  #get 'contact' => 'message#new', as: 'contact'

  get 'help' => 'help#index'
  post 'help/:id' => 'help#show', as: 'view_user'
  delete "help/:id" => "help#revert_show", as: 'revert_view_user'
  
  devise_for :users
  
  #devise_for :users#, :skip => [:registrations]
  # as :user do
  #   get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
  #   put 'users' => 'devise/registrations#update', :as => 'user_registration'
  #   get 'users/invitation' => 'welcome#reinvite', as: 'resend_user_invitation'
  #   put 'users/invitation/resend' => 'welcome#invite'
  # end

  mount_griddler

  get 'dashboard' => 'dashboard#index'
  post 'dashboard' => 'dashboard#index'

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  mount API::Root => '/'
end
