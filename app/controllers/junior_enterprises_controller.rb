class JuniorEnterprisesController < ApplicationController  
  before_action :set_junior_enterprise, only: [:edit, :update, :destroy]

  # GET /junior_enterprises
  # GET /junior_enterprises.json
  def index
    @junior_enterprises = JuniorEnterprise.all.page(params[:page]).per(10)
    if is_admin?
      render template: "admin/junior_enterprise_index"
    end 
  end

  # GET /junior_enterprises/1
  # GET /junior_enterprises/1.json
  def show    
    @message = Message.new
    @junior_enterprise = JuniorEnterprise.find(params[:id])
    @junior_enterprise.access=+1
    @junior_enterprise.save
    @user = User.find(@junior_enterprise.user_id)


    if ( !@junior_enterprise.state.blank? && !@junior_enterprise.city.blank? && !@junior_enterprise.address.blank?)
      @mapAddress = @junior_enterprise.address.tr(" ", "+")+","+@junior_enterprise.city.tr(" ", "+")+","+@junior_enterprise.state.tr(" ", "+")
    end
  end

  # GET /junior_enterprises/new
  def new
    @junior_enterprise = JuniorEnterprise.new
    if is_admin?
      render template: "admin/junior_enterprise_new"
    end 
  end

  # GET /junior_enterprises/1/edit
  def edit
    if is_admin?
      render template: "admin/junior_enterprise_edit"
    end 
  end

  # POST /junior_enterprises
  # POST /junior_enterprises.json
  def create
    @junior_enterprise = JuniorEnterprise.new(junior_enterprise_params)
    respond_to do |format|
      if @junior_enterprise.save
        current_user.junior_enterprise = @junior_enterprise
        current_user.save
        if is_admin?
          format.html { redirect_to "/admin/junior_enterprises"}
        else
          format.html { redirect_to "/dashboard"}
        end
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /junior_enterprises/1
  # PATCH/PUT /junior_enterprises/1.json
  def update
    respond_to do |format|
      if @junior_enterprise.update(junior_enterprise_params)
        if is_admin?          
          format.html { redirect_to "/admin/junior_enterprises"}
        else          
          format.html { redirect_to "/junior_enterprises/edit"}
        end
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /junior_enterprises/1
  # DELETE /junior_enterprises/1.json
  def destroy
    @junior_enterprise.destroy
    respond_to do |format|
      if is_admin?        
        format.html { redirect_to "/admin/junior_enterprises" }
      else        
        format.html { redirect_to "/log_out" }
      end
    end
  end

  def dashboard
    if current_user.junior_enterprise == nil
      redirect_to "/junior_enterprises/new"
    end
  end

  def find
  end

  def search
    @je = JuniorEnterprise.all.page(params[:page]).per(10)

    if params[:name]
      unless params[:name].blank?
        @je = @je.where("name like ?", "%#{params[:name]}%")
      end
    end

    if params[:state]
      unless params[:state].blank?
        @je = @je.where(["state = :state",{ state: params[:state]}])
      end
    end

    if params[:area]
      unless params[:area].blank?
        @je = @je.where("area like ?", "%#{params[:area]}%")
      end
    end

    if params[:consultor]
      if params[:consultor] == 'true'
        @je = @je.where(["consultor = :consultor",{ consultor: true}])
      end
    end

    if params[:training]
      if params[:training] == 'true'
        @je = @je.where(["training = :training",{ training: true}])
      end
    end

    if params[:product]
      if params[:product] == 'true'
        @je = @je.where(["product = :product",{ product: true}])
      end
    end

    if params[:project]
      if params[:project] == 'true'
        @je = @je.where(["project = :project",{ project: true}])
      end
    end
  end

  def messages
  end

  private
    def set_junior_enterprise
      if is_admin?
        @junior_enterprise = JuniorEnterprise.find(params[:id])
      else
        @junior_enterprise = current_user.junior_enterprise
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def junior_enterprise_params
      params.require(:junior_enterprise).permit(:name, :logo, :description, :phrase, :site, :phone, :city, :state, :facebook, :youtube, :course, :area, :address, :training, :consultor, :product, :project)
    end
end
