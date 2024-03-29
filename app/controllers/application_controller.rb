# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def after_sign_in_path_for(_resource)
    designs_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:account_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:account_name])
  end
end
