Rails.application.routes.draw do
  namespace :api, format: false, defaults: { format: :json } do
    get 'exchange_rates', to: 'currency_exchange_rates#result'
    get 'conversion', to: 'currency_exchange_rates#convert'
  end
end
