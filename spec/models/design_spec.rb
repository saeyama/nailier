# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Design, type: :model do
  it 'is valid with a title and nail_part' do
    user = FactoryBot.create(:user)
    design = user.designs.new(user_id: user.id, title: 'test', nail_part: 'hand')
    expect(design).to be_valid
  end
end
