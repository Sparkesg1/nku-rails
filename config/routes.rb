NkuRails::Application.routes.draw do
 
  get "students/index"
  get "students/new"
  get "students/edit"
  get "sessions/index"
  get "sessions/new"
  resources :sessions, :students
 
  root to: "sessions#index"
end