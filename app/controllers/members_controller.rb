class MembersController < ApplicationController

  def index
    current_user
    @members = []

    result = HTTParty.get("http://jeapi.herokuapp.com/members", 
    :body => { :token => JEAPI_KEY })

    ActiveSupport::JSON.decode(result.body).each do |m|
      member = OpenStruct.new(m)
      
      if is_admin?(@current_user)
        @members << member
      else
        if m["junior_enterprise_id"] == @current_user.junior_enterprise.id
          @members << member
        end
      end
    end

    @members = Kaminari.paginate_array(@members).page(params[:page]).per(10)


    if is_admin?(@current_user)
      render template: "admin/member_index"
    elsif is_federation?

    else
      number_of_messages
    end
  end

  def new
    number_of_messages
    current_user

    @member = Member.new
    
    @junior_enterprises = []

    result = HTTParty.get("http://jeapi.herokuapp.com/junior_enterprises", 
    :body => { :token => JEAPI_KEY })

    ActiveSupport::JSON.decode(result.body).each do |junior_enterprise|
      @junior_enterprises << OpenStruct.new(junior_enterprise)
    end

    is_admin?(@current_user) ? (render template: "admin/member_new") : ()
  end

  def edit
    current_user
    number_of_messages

    @junior_enterprises = []

    result_member = HTTParty.get("http://jeapi.herokuapp.com/members/#{params[:id]}", 
    :body => { :token => JEAPI_KEY })

    @member = Member.new(ActiveSupport::JSON.decode(result_member.body))

    result_je = HTTParty.get("http://jeapi.herokuapp.com/junior_enterprises", 
    :body => { :token => JEAPI_KEY })

    ActiveSupport::JSON.decode(result_je.body).each do |junior_enterprise|
      @junior_enterprises << OpenStruct.new(junior_enterprise)
    end

    is_admin?(@current_user) ? (render template: "admin/member_edit") : () 
  end

  def create
    number_of_messages
    current_user

    @member = Member.new(member_params)

    is_admin?(@current_user) ? () : (@member.junior_enterprise_id = @current_user.junior_enterprise.id)

    @member.save!

    result = HTTParty.post("http://jeapi.herokuapp.com/members",
    :body => {:name => @member.name, :phone => @member.phone, :email => @member.email, :photo => @member.photo_url.to_s, :position => @member.position, :junior_enterprise_id => @member.junior_enterprise_id, :token => JEAPI_KEY  })

    @member.destroy
    if result.code == 201
      if is_admin?(@current_user)         
        redirect_to "/admin/members", notice: "Criado com sucesso"
      else
        redirect_to "/members", notice: "Criado com sucesso"
      end
    else
      @errors = JSON.parse(result.body)
      is_admin?(@current_user) ? (render template: "admin/member_new") : (render :new)  
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update    
    current_user

    @member = Member.new(member_params)
    @member.save!

    is_admin?(@current_user) ? () : (@member.junior_enterprise_id = current_user.junior_enterprise.id)

    result = HTTParty.put("http://jeapi.herokuapp.com/members/#{params[:id]}",
    :body => {:name => @member.name, :phone => @member.phone, :email => @member.email, :photo => @member.photo_url.to_s, :position => @member.position, :junior_enterprise_id => @member.junior_enterprise_id, :token => JEAPI_KEY  })
  
    @member.destroy  
    if result.code == 204  
      if is_admin?(@current_user)
        redirect_to "/admin/members", notice: "Editado com sucesso"
      else          
        redirect_to "/members", notice: "Editado com sucesso"
      end
    else
      @errors = JSON.parse(result.body)
      is_admin?(@current_user) ? (render template: "admin/member_edit") : (render :edit)  
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    result = HTTParty.delete("http://jeapi.herokuapp.com/members/#{params[:id]}", 
    :body => { :token => JEAPI_KEY })

    if is_admin?
      redirect_to "/admin/members", notice: "Deletado com sucesso"
    else        
      redirect_to "/members", notice: "Deletado com sucesso"
    end 
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:name, :photo, :position, :junior_enterprise_id, :email, :phone)
    end
end
