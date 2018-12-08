# frozen_string_literal: true

Rails.application.routes.draw do
  resources :notes
  resources :search, only: [:index]
  root 'notes#index'
end
