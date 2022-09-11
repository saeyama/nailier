# frozen_string_literal: true

class Design < ApplicationRecord
  validates :title, presence: true
  validates :nail_part, presence: true
  has_many_attached :images
end
