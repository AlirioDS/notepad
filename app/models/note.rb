# frozen_string_literal: true

class Note < ApplicationRecord
  validates :title, length: { maximum: 30 }, presence: true
  validates :content, length: { maximum: 400 }, presence: true

  include PgSearch
  pg_search_scope :search, against: %i[title content color]
end
