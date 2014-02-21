NkuRails::Application.routes.draw do

  resources :sessions, :students, :attendances

  root to: "students#index"
end