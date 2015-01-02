class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private
  def current_user
    unless session[:user_id].blank?
      result = HTTParty.get("http://jeapi.herokuapp.com/users/#{session[:user_id]}", :headers => { 'token' => JEAPI_KEY } )

      @current_user = OpenStruct.new(ActiveSupport::JSON.decode(result.body))
      if !@current_user.junior_enterprise.blank?
        @current_user.junior_enterprise = OpenStruct.new(@current_user.junior_enterprise)
      end

      return @current_user
    end
  end
  helper_method :current_user

  def loged_in?
    if current_user != nil
      true
    end
  end
  helper_method :loged_in?

  def is_admin?(object = current_user)
    if object != nil
      if object.function == "admin"
        return true
      end
    end

    return false
  end
  helper_method :is_admin?

  def is_federation?(object = current_user)
    if object != nil
      if object.function == "federation"
        return true
      end
    end

    return false
  end
  helper_method :is_federation?

  def number_of_messages
    current_user
    if !@current_user.junior_enterprise.blank?
      if !@current_user.junior_enterprise.messages.blank?
        i = 0
        @current_user.junior_enterprise.messages.each do |m|
          m["read"] == false ? i = i+1 : 0
        end
      end
    end

    return i
  end 
  helper_method :number_of_messages

  def check_and_redirect    
    if current_user == nil
      redirect_to "/log_in", :notice => "Faça um login para poder acessar"
    end
  end
  helper_method :check_and_redirect

  def check_admin_and_redirect
    if current_user == nil
      redirect_to "/log_in", :notice => "Entre como um Administrador"
    else
      if current_user.function != "admin"
        redirect_to "/log_in", :notice => "Entre como um Administrador"
      end
    end
  end
end
