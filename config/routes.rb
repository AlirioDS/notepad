# frozen_string_literal: true

Rails.application.routes.draw do
  resources :notes
  root 'notes#index'
end
