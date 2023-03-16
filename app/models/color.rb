# frozen_string_literal: true

class Color < ApplicationRecord
  validates :hex_number, presence: true

  belongs_to :design
end
