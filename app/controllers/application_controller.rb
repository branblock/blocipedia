class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def resource_name
      :user
    end

    def resource
      @resource ||= User.new
    end

    def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
    end

  helper_method :resource, :resource_name, :devise_mapping

  def after_sign_in_path_for(resource)
    wikis_path
  end

  private
  def user_not_authorized
    flash[:alert] = "You are not authorized to view this page or perform this action."
    redirect_to(request.referrer || root_path)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end
end
