Rails.application.routes.draw do
  get 'dashboard/index'

  resources :test_runs, :automation_runs, :tests

  root 'dashboard#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
