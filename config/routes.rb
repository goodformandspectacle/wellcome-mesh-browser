Rails.application.routes.draw do

  resources :records, only: ['show']

  resources :tree, only: [:index, :show], constraints: {id: /[^\.]+/}

end
