class SessionController < ApplicationController

  def index
  end		

  def new
  end

  def create
  	user = User.find_by password: params[:password], email: params[:email]
    if user != nil
      session[:user_id] = user.id
      redirect_to , :notice => "Logged in!"
    else
      redirect_to "/log_in", :notice => "Invalid Password"     
    end
  end

  def destroy  	
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

end
