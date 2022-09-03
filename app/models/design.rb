# frozen_string_literal: true

class Design < ApplicationRecord
  validates :title, presence: true
  validates :nail_part, presence: true
end
