# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Design, type: :model do
  it 'is valid with a title and nail_part' do
    design = Design.new(title: 'test', nail_part: 'hand')
    expect(design).to be_valid
  end
end
