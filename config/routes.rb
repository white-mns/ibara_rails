Rails.application.routes.draw do
  resources :move_party_counts
  resources :next_battle_enemies
  resources :next_battle_infos
  resources :moves
  resources :party_infos
  resources :compounds
  get "styles",  :to => "statuses#style",  :as => "styles"
  get "effects", :to => "statuses#effect", :as => "effects"
  resources :statuses
  resources :cards
  resources :studies
  resources :parties
  resources :places
  resources :skill_masteries
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
