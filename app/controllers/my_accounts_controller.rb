# frozen_string_literal: true

class MyAccountsController < ApplicationController
  def show
    @hand = current_user.designs.where(nail_part: 'ハンド')
    @foot = current_user.designs.where(nail_part: 'フット')
  end
end
