class JuniorEnterprisesController < ApplicationController
  before_action :number_of_messages, only: [:members, :edit, :dashboard]

  # GET /junior_enterprises
  # GET /junior_enterprises.json
  def index
    @junior_enterprises = []

    result = HTTParty.get("http://jeapi.herokuapp.com/junior_enterprises", 
    :body => { :token => JEAPI_KEY })

    ActiveSupport::JSON.decode(result.body).each do |junior_enterprise|
      je = OpenStruct.new(junior_enterprise)

      @junior_enterprises << je
    end

    @junior_enterprises = Kaminari.paginate_array(@junior_enterprises).page(params[:page]).per(10)

    if is_admin?
      render template: "admin/junior_enterprise_index"
    elsif is_federation?

    end 
  end

  # GET /junior_enterprises/1
  # GET /junior_enterprises/1.json
  def show    
    @message = Message.new

    result_je = HTTParty.get("http://jeapi.herokuapp.com/junior_enterprises/#{params[:id]}", 
    :body => { :token => JEAPI_KEY })

    @junior_enterprise = OpenStruct.new(ActiveSupport::JSON.decode(result_je.body))


    result_user = HTTParty.get("http://jeapi.herokuapp.com/users/#{@junior_enterprise.user_id}", 
    :body => { :token => JEAPI_KEY })

    @user = OpenStruct.new(ActiveSupport::JSON.decode(result_user.body))

    streeAddress = @junior_enterprise.address.tr(",-/", " ")
    streeAddress = streeAddress.split.join(" ")
    streeAddress = streeAddress.tr(" ", "+")


    if ( !@junior_enterprise.state.blank? && !@junior_enterprise.city.blank? && !@junior_enterprise.address.blank?)
      @mapAddress = streeAddress + "," + @junior_enterprise.city.tr(" ", "+") + "," + @junior_enterprise.state.tr(" ", "+")
    end
  end

  # GET /junior_enterprises/new
  def new
    @junior_enterprise = JuniorEnterprise.new
    if is_admin?
      render template: "admin/junior_enterprise_new"
    elsif is_federation?
    end 
  end

  # GET /junior_enterprises/1/edit
  def edit
    current_user

    is_admin?(@current_user) ? (@id = params[:id]) : (@id = current_user.junior_enterprise.id)

    result = HTTParty.get("http://jeapi.herokuapp.com/junior_enterprises/#{@id}", 
    :body => { :token => JEAPI_KEY })

    //
    hash = ActiveSupport::JSON.decode(result.body)
    hash.delete("messages")
    hash.delete("members")
    //

    @junior_enterprise = JuniorEnterprise.new(hash)

    if is_admin?(@current_user)
      render template: "admin/junior_enterprise_edit"
    end 
  end

  # POST /junior_enterprises
  # POST /junior_enterprises.json
  def create
    @junior_enterprise = JuniorEnterprise.new(junior_enterprise_params) 
    @junior_enterprise.save!

    is_admin? ? (@user_id = @junior_enterprise.id) : (@user_id = current_user.id) 

    result = HTTParty.post("http://jeapi.herokuapp.com/junior_enterprises",
    :body => {:name => @junior_enterprise.name, :user_id => @user_id, :logo => @junior_enterprise.logo_url.to_s , :description => @junior_enterprise.description, :phrase => @junior_enterprise.phrase, :phrase => @junior_enterprise.phrase, :site => @junior_enterprise.site, :phone => @junior_enterprise.phone, :city => @junior_enterprise.city, :state => @junior_enterprise.state, :youtube => @junior_enterprise.youtube, :facebook => @junior_enterprise.facebook, :course => @junior_enterprise.course, :area => @junior_enterprise.area, :address => @junior_enterprise.address, :consultor => @junior_enterprise.consultor, :product => @junior_enterprise.product, :access => 0, :project => @junior_enterprise.project, :training => @junior_enterprise.training, :token => JEAPI_KEY  })
    
    @junior_enterprise.destroy
    if result.code == 201
      if is_admin? 
        redirect_to "/admin/junior_enterprises", notice: "Criado com sucesso"
      else
        redirect_to "/dashboard", notice: "Criado com sucesso"
      end
    else
      @errors = JSON.parse(result.body)
      is_admin?(@current_user) ? (render template: "admin/junior_enterprise_new") : (render :new)  
    end
  end

  def update
    current_user
    @junior_enterprise = JuniorEnterprise.new(junior_enterprise_params)
    @junior_enterprise.save!

    is_admin?(@current_user) ? @user_id = @junior_enterprise.user_id : @user_id = @current_user.id

    result = HTTParty.put("http://jeapi.herokuapp.com/junior_enterprises/#{params[:id]}",
    :body => {:name => @junior_enterprise.name, :user_id => @user_id, :logo => @junior_enterprise.logo_url.to_s , :description => @junior_enterprise.description, :phrase => @junior_enterprise.phrase, :phrase => @junior_enterprise.phrase, :site => @junior_enterprise.site, :phone => @junior_enterprise.phone, :city => @junior_enterprise.city, :state => @junior_enterprise.state, :youtube => @junior_enterprise.youtube, :facebook => @junior_enterprise.facebook, :course => @junior_enterprise.course, :area => @junior_enterprise.area, :address => @junior_enterprise.address, :consultor => @junior_enterprise.consultor, :product => @junior_enterprise.product, :access => 0, :project => @junior_enterprise.project, :training => @junior_enterprise.training, :token => JEAPI_KEY  })
    
    @junior_enterprise.destroy
    if result.code == 204      
      if is_admin? @current_user
        redirect_to "/admin/junior_enterprises", notice: "Editado com sucesso"
      else
        redirect_to "/junior_enterprises/edit", notice: "Editado com sucesso"
      end
    else
      @errors = JSON.parse(result.body)
      is_admin?(@current_user) ? (render template: "admin/junior_enterprise_edit") : (render :edit)  
    end
  end

  # DELETE /junior_enterprises/1
  # DELETE /junior_enterprises/1.json
  def destroy
    result = HTTParty.delete("http://jeapi.herokuapp.com/junior_enterprises/#{params[:id]}", 
    :body => { :token => JEAPI_KEY })

    if is_admin? 
      redirect_to "/admin/junior_enterprises", notice: "Deletado com sucesso"
    else
      redirect_to "/log_out", notice: "Deletado com sucesso"
    end
  end

  def dashboard
    current_user.junior_enterprise.nil? ? (redirect_to "/junior_enterprises/new") : ""
  end

  def find
  end

  def search
    @je = []

    result = HTTParty.get("http://jeapi.herokuapp.com/search", 
    :body => { :name => params[:name], :state => params[:state], :area => params[:area], :consultor => params[:consultor],
              :project => params[:project], :training => params[:training], :product => params[:product], :token => JEAPI_KEY })

    ActiveSupport::JSON.decode(result.body).each do |junior_enterprise|
      @je << OpenStruct.new(junior_enterprise)
    end

    @je = Kaminari.paginate_array(@je).page(params[:page]).per(10)
  end

  def messages
    current_user
    @number_of_messages = 0

    @messages = Kaminari.paginate_array(@current_user.junior_enterprise.messages).page(params[:page]).per(10)

    result = HTTParty.put("http://jeapi.herokuapp.com/messages/read",
    :body => {:id => @current_user.junior_enterprise.id, :token => JEAPI_KEY  })
  end

  private
    def set_junior_enterprise
      if is_admin?
        result_je = HTTParty.get("http://jeapi.herokuapp.com/junior_enterprises/#{params[:id]}", 
        :body => { :token => JEAPI_KEY })

        @junior_enterprise = OpenStruct.new(ActiveSupport::JSON.decode(result_je.body))
      else
        @junior_enterprise = current_user.junior_enterprise
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def junior_enterprise_params
      params.require(:junior_enterprise).permit(:access, :user_id,:name, :logo, :description, :phrase, :site, :phone, :city, :state, :facebook, :youtube, :course, :area, :address, :training, :consultor, :product, :project)
    end
end
