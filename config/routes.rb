Rails.application.routes.draw do
  root 'home#index'

  get '/:id' => 'beats#show'
  post '/:id' => 'beats#create'

end
