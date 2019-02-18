Rails.application.routes.draw do
  resources :skills
  resources :skill_data
  resources :superpowers
  resources :superpower_data
  resources :items
  resources :proper_names
  get "world/graph", :to => "worlds#graph", :as => "world_graphs"
  resources :worlds
  resources :names
  get "top_page/privacy"
  root "top_page#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
