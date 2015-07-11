Uidiary::Application.routes.draw do

  root to: 'apps#index'

  match 'apps/list', :to => 'apps#list', :via => :get
  resources :apps
  match 'apps/add', :to => 'apps#add', :via => :post
  match 'apps/new', :to => 'apps#new', :via => :post

  devise_for :users, controllers: {
    sessions: 'devise/sessions'
  }

end
