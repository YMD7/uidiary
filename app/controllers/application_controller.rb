class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # deviceのコントローラーのときに、下記のメソッドを呼ぶ
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      # sign_inのパラメータ許可
      devise_parameter_sanitizer.for(:sign_in) << :email
      devise_parameter_sanitizer.for(:sign_in) << :password
      # sign_upのパラメータ許可
      devise_parameter_sanitizer.for(:sign_up) << :username
      devise_parameter_sanitizer.for(:sign_up) << :email
      #  account_updateのパラメータ許可
      devise_parameter_sanitizer.for(:account_update) << :username
    end

end
