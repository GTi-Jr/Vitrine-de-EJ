class SessionController < ApplicationController

  def index
  end	

  def explanation
  end	

  def new
  end

  def create
    user = User.find_by password: params[:password], email: params[:email]
    if user != nil
      session[:user_id] = user.id
      if is_admin?
        redirect_to "/admin/users", :notice => "Logged in!"
      else
        redirect_to dashboard_path, :notice => "Logged in!"
      end
    else
      redirect_to "/log_in", :notice => "Password ou Email inválido"     
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end
