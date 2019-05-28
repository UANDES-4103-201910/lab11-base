Rails.application.routes.draw do
  root to: "home#index"

  get 'shopping_cart', to: 'shopping_carts#index'
  get 'shopping_cart/add/:ticket_type_id/:amount', to: 'shopping_carts#add_ticket', defaults: { amount: 1 }
  post 'shopping_cart/add', to: 'shopping_carts#add_ticket'
  get 'checkout', to: 'shopping_carts#checkout'

  resources :events
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
