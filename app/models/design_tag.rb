# frozen_string_literal: true

class DesignTag < ApplicationRecord
  belongs_to :design
  belongs_to :tag
end
