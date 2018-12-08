# frozen_string_literal: true

class Note < ApplicationRecord 
  validates :title, length: { maximum: 30 }, presence: true
  validates :content, presence: true

  include PgSearch
  pg_search_scope :search, against: [:title, :content, :color]
end
