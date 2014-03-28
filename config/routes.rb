NkuRails::Application.routes.draw do

  get 'students/upload', to: "students#upload", as: :students_upload
  post 'students/upload', to: "students#process_upload", as: :students_process_upload
  get 'assignments/upload', to: "assignments#upload", as: :assignments_upload
  post 'assignments/upload', to: "assignments#process_upload", as: :assignments_process_upload

  resources :sessions, :students, :attendances, :assignments
  root to: "students#index"
end