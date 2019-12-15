Rails.application.routes.draw do
  devise_for :users
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get '/', to: redirect('/admin')

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
