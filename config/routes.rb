Rails.application.routes.draw do
  root 'loans#new'
  resources :loans do
    collection do
      get 'inspect'
    end
  end
  get 'loans/serve/inspect' => 'loans#inspect'

end
