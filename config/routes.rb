Happiness::Application.routes.draw do
  resources :surveys, only: [:index, :create] do
    resources :questions, only: [:index, :create]
  end
end
