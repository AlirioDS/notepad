# frozen_string_literal: true

class Note < ApplicationRecord
  include PgSearch
  validates :title, length: { maximum: 30 }, presence: true
  validates :content, presence: true
end
