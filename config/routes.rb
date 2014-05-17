Happiness::Application.routes.draw do
  resources :surveys, only: [:index, :create] do
    resources :survey_questions, only: [:index, :create, :show, :update] 
  end
end
