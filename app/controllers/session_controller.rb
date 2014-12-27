class SessionController < ApplicationController

  def index
  end	

  def explanation
  end	

  def new
  end

  def help
  end

  def create
    result = HTTParty.get("http://jeapi.herokuapp.com/log_in", 
    :body => { password: params[:password], email: params[:email]},
    :headers => { 'token' => JEAPI_KEY } )


    if result.code != 204
      user = OpenStruct.new(ActiveSupport::JSON.decode(result.body))
      session[:user_id] = user.id
      if is_admin? 
        redirect_to "/admin/users", :notice => "Logged in!"
      elsif is_federation?       
        redirect_to "/federation/dashboard", :notice => "Logged in!"
      else
        redirect_to dashboard_path, :notice => "Logged in!"
      end
    else
      redirect_to "/log_in", :alert => "Password ou Email inválido"     
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged Out!"
  end

end
