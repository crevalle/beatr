Rails.application.routes.draw do
  root 'home#index'

  post '/' => 'home#hot'

  get '/socks' => 'beats#dashboard', as: :dashboard
  get '/:id' => 'beats#show', as: :beats
  post '/:id' => 'beats#create'

end
