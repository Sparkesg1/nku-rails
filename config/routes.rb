NkuRails::Application.routes.draw do
  resources :posts do
    resources :comments
  end
  root to: "posts#new.html.erb"
end