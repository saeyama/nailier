# frozen_string_literal: true

class DesignTag < ApplicationRecord
  belongs_to :design
  belongs_to :tag

  validates :design_id, presence: true
  validates :tag_id, presence: true
end
