# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def privacy_policy; end

  def tos; end
end
