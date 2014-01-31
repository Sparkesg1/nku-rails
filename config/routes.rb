NkuRails::Application.routes.draw do
 
  get "students/index"
  get "students/new"
  get "students/edit"
  resources :students
 
  root to: "students#index"
end