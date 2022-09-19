# frozen_string_literal: true

class Part < ApplicationRecord
  validates :name, presence: true
  validates :quantity, presence: true
end
