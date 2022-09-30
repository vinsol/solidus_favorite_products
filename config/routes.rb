# frozen_string_literal: true

Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resources :favorite_products, only: :index do
      get :users, on: :member, to: 'products#favorite_users'
    end

    resources :products do
      get :favorite_users, on: :member
    end

    resources :users do
      get :favorite_products, on: :member
    end
  end

  resources :favorite_products, only: [:index, :create, :destroy]
end
