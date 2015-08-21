Rails.application.routes.draw do
  root 'home#index'
  # match '/websocket', to: WebsocketRails::ConnectionManager.new, via: [:get, :post]

  get '/:id' => 'beats#show'
  post '/:id' => 'beats#create'

end
