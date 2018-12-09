# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)", locale: /en|es/ do
    resources :notes
    resources :search, only: [:index]
    root 'notes#index'
    get 'notes/edit', to: 'notes#edit'
  end
end
