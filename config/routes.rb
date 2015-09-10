Rails.application.routes.draw do
  root 'home#index'

  post '/' => 'home#hot'

  get '/:id' => 'beats#show', as: :beats
  post '/:id' => 'beats#create'

end
