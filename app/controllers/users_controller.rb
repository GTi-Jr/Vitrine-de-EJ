class UsersController < ApplicationController
  before_action :check_admin_and_redirect, only: [:index, :destroy, :edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = []

    result = HTTParty.get("http://jeapi.herokuapp.com/users", 
    :body => { :token => JEAPI_KEY })

    ActiveSupport::JSON.decode(result.body).each do |user|
      @users << OpenStruct.new(user)
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


    //
    user = ActiveSupport::JSON.decode(result.body)
    user.delete("junior_enterprise")
    //

    @user = User.new(user)
    if is_admin?
      render template: "admin/user_edit"
    end 
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)    
    
    if is_admin?
      function = user_params["function"]
    else
      function = "user"
    end

    result = HTTParty.post("http://jeapi.herokuapp.com/users",
    :body => { :email => @user.email, :function => function, :token => JEAPI_KEY  })

    respond_to do |format|
      if result.code == 201
        if is_admin?
          format.html { redirect_to "/admin/users"}
        else
          format.html { redirect_to "/log_in", notice: 'Sua senha foi enviada para seu e-mail' }
        end
      else
        @errors = JSON.parse(result.body)
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.new(user_params)
      
    result = HTTParty.put("http://jeapi.herokuapp.com/users/#{params[:id]}",
    :body => {:email => @user.email, :password => @user.password, :function => @user.function, :token => JEAPI_KEY  })    
    if result.code == 204
      if is_admin?
        redirect_to "/admin/users"
      end 
    else
      flash[:error] = result.errors
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy    
    result = HTTParty.delete("http://jeapi.herokuapp.com/users/#{params[:id]}", 
    :body => { :token => JEAPI_KEY })

    if is_admin?
      redirect_to "/admin/users"
    else
      redirect_to "/"
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
