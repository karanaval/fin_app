Rails.application.routes.draw do

  get 'reports/index'
  post 'reports/index', to: 'reports#choose_report_type'

  get 'reports/report_by_category'
  post 'reports/report_by_category'

  get 'reports/report_by_dates'
  post 'reports/report_by_dates'

  root 'main#index'
  get 'main/index'
  resources :operations
  resources :categories
  
end
