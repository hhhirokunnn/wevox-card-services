# frozen_string_literal: true

Rails.application.routes.draw do
  namespace "api" do
    namespace "v1" do
      resources :users
      resources :games do
        resources :players
        resources :cards
      end
      put "start_game/:id" => "games#start_game"
      post  "login" => "sessions#create"
      get   "test" => "sessions#index"
    end
  end
end
