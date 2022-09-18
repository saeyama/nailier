# frozen_string_literal: true

class Color < ApplicationRecord
  validates :lame, inclusion: { in: [true, false] }
  validates :hex_number, presence: true

  belongs_to :design
end
