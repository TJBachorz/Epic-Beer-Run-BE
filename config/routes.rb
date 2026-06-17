Rails.application.routes.draw do
  get "/health", to: proc { [200, {}, [""]] }
  resources :breweries, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
