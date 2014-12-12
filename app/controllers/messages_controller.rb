class MessagesController < ApplicationController  
  before_action :set_message, only: [:edit, :destroy]

  def index
    @messages = []

    result = HTTParty.get("http://jeapi.herokuapp.com/messages", 
    :body => { :token => JEAPI_KEY })

    ActiveSupport::JSON.decode(result.body).each do |message|
      @messages << Message.new(message)
    end

    @messages = Kaminari.paginate_array(@messages).page(params[:page]).per(10)
    
    if is_admin?
      render template: "admin/message_index"
    end    
  end

  def new
    @message = Message.new
    @junior_enterprises = []

    result = HTTParty.get("http://jeapi.herokuapp.com/junior_enterprises", 
    :body => { :token => JEAPI_KEY })

    ActiveSupport::JSON.decode(result.body).each do |junior_enterprise|
      //
      junior_enterprise.delete("messages")
      junior_enterprise.delete("members")
      //

      @junior_enterprises << JuniorEnterprise.new(junior_enterprise)
    end

    if is_admin?
      render template: "admin/message_new"
    end 
  end

  def edit
    if is_admin?
      render template: "admin/message_edit"
    end 
  end

  def create
    current_user
    @message = Message.new(message_params)    
    
    result = HTTParty.post("http://jeapi.herokuapp.com/messages",
    :body => {:text => @message.text, :email => @message.email, :phone => @message.phone, :name => @message.name, :junior_enterprise_id => params["id"], :read => false, :token => JEAPI_KEY  })

    if result.code == 201
      if is_admin?(@current_user)         
        redirect_to "/admin/messages"
      else
        redirect_to "/junior_enterprise/#{params[:id]}"
      end
    else
      render :new 
    end
  end

  def update
    current_user
    @message = Message.new(message_params)

    result = HTTParty.put("http://jeapi.herokuapp.com/messages/#{params[:id]}",
    :body => {:text => @message.text, :email => @message.email, :phone => @message.phone, :name => @message.name, :junior_enterprise_id => @message.junior_enterprise_id, :read => false, :token => JEAPI_KEY  })

    if result.code == 204      
      if is_admin?          
        redirect_to "/admin/messages"
      end
    end
  end


  def destroy
    current_user
    is_admin?(@current_user) ? @id = @message.id : @id = params[:id] 

    result = HTTParty.delete("http://jeapi.herokuapp.com/messages/#{@id}", 
    :body => { :token => JEAPI_KEY })   

    is_admin?(@current_user) ? redirect_to "/admin/messages" : redirect_to "/messages"
  end

  private
    def set_message
      if is_admin?
        result = HTTParty.get("http://jeapi.herokuapp.com/messages/#{params[:id]}", 
         :body => { :token => JEAPI_KEY })
        @message = Message.new(ActiveSupport::JSON.decode(result.body))
      end
    end


    def message_params
      params.require(:message).permit(:name, :email, :text, :phone)
    end
end
