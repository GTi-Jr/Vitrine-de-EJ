class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def loged_in?
    if current_user != nil
      true
    end
  end
  helper_method :loged_in?

  def is_admin?
    if current_user != nil
      if current_user.is_admin?
        true
      end
    end
  end
  helper_method :loged_in?

  def check_and_redirect
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    if @current_user == nil
      redirect_to "/log_in", :notice => "Faça um login para poder acessar"
    end
  end
  helper_method :check_and_redirect

    def check_admin_and_redirect
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    if @current_user == nil
      redirect_to "/log_in", :notice => "Entre como um Administrador"
    else
      if @current_user.function != "admin"
        redirect_to "/log_in", :notice => "Entre como um Administrador"
      end
    end
  end
  helper_method :check_and_redirect
end
