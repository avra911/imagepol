Rails.application.routes.draw do
  resources :photos, only: :rate do
    member do
      patch :rate
    end
  end

  resources :albums do
    member do
      post :unlock
    end
  end

  resources :domains

  namespace :manage do
    resources :albums
    resources :domains
    resources :photos, except: [:new, :edit, :show, :index]
  end

  match 'public/:domain_name/:id/:suffix(.:format)' => 'manage/albums#view', :domain_name => /[A-Za-z0-9\.]+?/, :via => [:get], :as => 'domain_album'

  devise_for :user, :controllers => { :registrations => 'users/registrations', :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_for :admins
  
  mount RailsAdmin::Engine => '/backend', as: 'rails_admin'

  root 'albums#home'
end
