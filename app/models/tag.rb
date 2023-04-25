# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :design_tags, dependent: :destroy
  has_many :designs, through: :design_tags
  validates :name, presence: true, uniqueness: true
end
