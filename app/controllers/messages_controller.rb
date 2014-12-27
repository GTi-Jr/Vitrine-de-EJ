class MessagesController < ApplicationController  
  before_action :set_message, only: [:edit, :destroy]

  def index
    @messages = []

    result = HTTParty.get("http://jeapi.herokuapp.com/messages",
    :headers => { 'token' => JEAPI_KEY } )

    ActiveSupport::JSON.decode(result.body).each do |message|
      @messages << Message.new(message)
    end

    @messages = Kaminari.paginate_array(@messages).page(params[:page]).per(10)
    
    if is_admin? 
      render template: "admin/message_index"  
    elsif is_federation?

    end
  end

  def new
    @message = Message.new
    @junior_enterprises = []

    result = HTTParty.get("http://jeapi.herokuapp.com/junior_enterprises",
    :headers => { 'token' => JEAPI_KEY } )

    ActiveSupport::JSON.decode(result.body).each do |junior_enterprise|
      //
      junior_enterprise.delete("messages")
      junior_enterprise.delete("members")
      //

      @junior_enterprises << JuniorEnterprise.new(junior_enterprise)
    end

    is_admin? ? (render template: "admin/message_new") : ()
  end

  def edit
    is_admin? ? (render template: "admin/message_edit") : ()
  end

  def create
    current_user
    @message = Message.new(message_params)    
    
    result = HTTParty.post("http://jeapi.herokuapp.com/messages",
    :body => {:text => @message.text, :email => @message.email, :phone => @message.phone, :name => @message.name, :junior_enterprise_id => params["id"], :read => false },
    :headers => { 'token' => JEAPI_KEY } )

    if result.code == 201
      if is_admin?(@current_user)         
        redirect_to "/admin/messages", notice: "Mensagem enviada"        
      else
        redirect_to "/junior_enterprise/#{params[:id]}", notice: "Mensagem enviada"
      end
    else
      @errors = JSON.parse(result.body)
      is_admin?(@current_user) ? (render template: "admin/message_new") : (redirect_to :back, alert: "Preencha os dados corretamente")  
    end
  end

  def update
    current_user
    @message = Message.new(message_params)

    result = HTTParty.put("http://jeapi.herokuapp.com/messages/#{params[:id]}",
    :body => {:text => @message.text, :email => @message.email, :phone => @message.phone, :name => @message.name, :junior_enterprise_id => @message.junior_enterprise_id, :read => false },
    :headers => { 'token' => JEAPI_KEY } )

    if result.code == 204      
      is_admin? ? (redirect_to "/admin/messages") : ()
    else
      @errors = JSON.parse(result.body)      
      is_admin?(@current_user) ? (render template: "admin/message_edit") : (render :edit)   
    end
  end


  def destroy
    current_user
    is_admin?(@current_user) ? @id = @message.id : @id = params[:id] 

    result = HTTParty.delete("http://jeapi.herokuapp.com/messages/#{@id}",
    :headers => { 'token' => JEAPI_KEY } )   

    if is_admin?(@current_user)
      redirect_to "/admin/messages", alert: "Mensagem deletada"
    else
      redirect_to "/messages", alert: "Mensagem deletada"
    end
  end

  private
    def set_message
      if is_admin?
        result = HTTParty.get("http://jeapi.herokuapp.com/messages/#{params[:id]}",
        :headers => { 'token' => JEAPI_KEY } )
        @message = Message.new(ActiveSupport::JSON.decode(result.body))
      end
    end


    def message_params
      params.require(:message).permit(:name, :email, :text, :phone)
    end
end
