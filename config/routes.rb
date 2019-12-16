Rails.application.routes.draw do
  resources :new_battle_enemies
  resources :new_next_enemies
  resources :battle_enemies
  resources :battle_results
  resources :meals
  get "b_rank/pt_totals",  :to => "battle_damages#pt_total",  :as => "battle_ranking_pt_totals"
  get "b_rank/totals",  :to => "battle_damages#total",  :as => "battle_ranking_totals"
  get "b_rank/singles", :to => "battle_damages#single", :as => "battle_ranking_singles"
  resources :battle_buffers
  resources :battle_targets
  resources :battle_damages
  resources :new_actions
  resources :new_item_fukas
  resources :uploaded_checks
  resources :battle_acters
  resources :battle_actions
  resources :battle_infos
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
