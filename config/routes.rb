# frozen_string_literal: true

Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      get 'hello' => 'hello#index'
      get 'test' => 'sessions#index'
      post   'login'      => 'sessions#create'
      delete 'logout'     => 'sessions#destroy'
    end
  end
end
