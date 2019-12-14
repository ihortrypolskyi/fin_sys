Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/', as: 'rails_admin'
  root 'dashboard#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
