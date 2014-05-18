Happiness::Application.routes.draw do
  resources :surveys, only: [:index, :create, :show] do
    resources :survey_questions, only: [:index, :create, :show, :update]
  end
end
