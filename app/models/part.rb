# frozen_string_literal: true

class Part < ApplicationRecord
  validates :name, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  belongs_to :design
end
