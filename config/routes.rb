NkuRails::Application.routes.draw do

  resources :sessions, :students, :attendances, :assignments
  
  root to: "students#index"
end