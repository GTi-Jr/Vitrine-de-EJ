class MembersController < ApplicationController

  # GET /members
  # GET /members.json
  def index
    @members = Member.all
    if is_admin?
      render template: "admin/member_index"
    end 
  end

  # GET /members/new
  def new
    @member = Member.new
    @junior_enterprises = JuniorEnterprise.all
    if is_admin?
      render template: "admin/member_new"
    end 
  end

  # GET /members/1/edit
  def edit
    @member = Member.find(params[:id])
    @junior_enterprises = JuniorEnterprise.all
    if is_admin?
      render template: "admin/member_edit"
    end 
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)
    respond_to do |format|
      if @member.save
        if is_admin?
          format.html { redirect_to "/admin/members"}
        end 
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update    
    @member = Member.find(params[:id])    
    respond_to do |format|
      if @member.update(member_params)
        if is_admin?
          format.html { redirect_to "/admin/members"}
        end 
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    respond_to do |format|
      if is_admin?
        format.html { redirect_to "/admin/members"}
      end 
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:name, :photo, :position, :junior_enterprise_id)
    end
end
