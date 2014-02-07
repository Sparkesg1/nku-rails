NkuRails::Application.routes.draw do
 
  get "students/index"
  get "students/new"
  get "students/edit"
  get "sessions/index"
  resources :sessions, :students
 
  root to: "students#index"
end