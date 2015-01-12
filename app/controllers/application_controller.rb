class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |e|
    redirect_to root_path, alert: "Access Denied!"
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up){ |u| u.permit(:email, :password, :password_confirmation, :first_name, :last_name, :user_type) }
    end

  private

    def current_ability
      @current_ability ||= Ability.new(current_user, request.params)
    end
end
