class UsersController < ApplicationController
  before_action :check_admin_and_redirect, only: [:index, :destroy, :edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = []

    result = HTTParty.get("http://jeapi.herokuapp.com/users", 
    :body => { :token => JEAPI_KEY })

    ActiveSupport::JSON.decode(result.body).each do |user|
      @users << User.new(user)
    end

    @users = Kaminari.paginate_array(@users).page(params[:page]).per(10)

    if is_admin?
      render template: "admin/user_index"
    end    
  end

  # GET /users/new
  def new
    @user = User.new
    if is_admin?
      render template: "admin/user_new"
    end 
  end

  # GET /users/1/edit
  def edit
    result = HTTParty.get("http://jeapi.herokuapp.com/users/#{params[:id]}", 
    :body => { :token => JEAPI_KEY })

    @user = User.new(ActiveSupport::JSON.decode(result.body))
    if is_admin?
      render template: "admin/user_edit"
    end 
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)    
    
    unless is_admin?
      @user.function = "user"
    end

    result = HTTParty.post("http://jeapi.herokuapp.com/users",
    :body => { :email => @user.email, :token => JEAPI_KEY  })

    respond_to do |format|
      if result.code == 201
        if is_admin?
          format.html { redirect_to "/admin/users"}
        else
          format.html { redirect_to "/log_in", notice: 'Sua senha foi enviada para seu e-mail' }
        end 
        UserNotifier.send_signup_email(@user).deliver
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    result = HTTParty.put("http://jeapi.herokuapp.com/users/#{params[:id]}", 
    :body => { :token => JEAPI_KEY })

    respond_to do |format|
      if @user.update(user_params)
        if current_user.is_admin?
          format.html { redirect_to "/admin/users" }
        end 
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy    
    result = HTTParty.delete("http://jeapi.herokuapp.com/users/#{params[:id]}", 
    :body => { :token => JEAPI_KEY })

    respond_to do |format|
      if current_user.is_admin?
        format.html { redirect_to "/admin/users"}
      end
    end
  end

  def recover
  end

  def recover_email
    result = HTTParty.post("http://jeapi.herokuapp.com/recover",
    :body => { :email => params[:email], :token => JEAPI_KEY  })

    if result.code == 200
      redirect_to :back, :notice => "Um e-mail foi enviado com sua nova senha"
    else
      redirect_to :back, :alert => "E-mail não cadastrado"     
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :function)
    end
end
