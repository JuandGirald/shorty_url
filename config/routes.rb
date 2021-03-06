Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'urls#index'

  resources :urls, only: [:create, :show]
  get '/:shortcode', to: 'urls#redirect', as: 'redirect'
  get '/url/not_found', to: 'urls#not_found'
end
