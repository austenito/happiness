Happiness::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  resources :surveys, only: [:index, :create, :show] do
    resources :survey_questions, only: [:index, :create, :show, :update]
  end

  resource :home, only: [:index]
  resources :day_charts, only: [:index]
  resources :place_charts, only: [:index]
  root to: 'surveys#index'
end
