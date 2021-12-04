Rails.application.routes.draw do
  resources :orders, only: %i[index show update] do
    resources :items, only: %i[index]
  end
end
