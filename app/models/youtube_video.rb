# frozen_string_literal: true

class YoutubeVideo < ApplicationRecord
  validates :access_code, presence: true

  belongs_to :design
end
