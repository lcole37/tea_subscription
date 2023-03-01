Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :subscriptions, only: %i[create update]
      resources :customers, only: %i[index show] do
        get '/subscriptions', to: 'customer_subscriptions#index'
      end
    end
  end
end
