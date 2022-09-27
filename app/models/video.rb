# frozen_string_literal: true

class Video < ApplicationRecord
  validates :access_code, presence: true
end
