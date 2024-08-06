Rails.application.routes.draw do
  resources :accounts, only: [:create, :show] do
    resources :transactions, only: [:create, :index]
  end
end