Rails.application.routes.draw do

  get 'reports/index'

  # post 'reports/chose_report_type', to: 'reports#chose_report_type'

  get 'reports/report_by_category'
  post 'reports/report_by_category'

  get 'reports/report_by_dates'
  post 'reports/report_by_dates'

  root 'main#index'
  get 'main/index'
  resources :operations
  resources :categories
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
