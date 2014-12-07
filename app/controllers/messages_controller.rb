class MessagesController < ApplicationController  
  before_action :set_message, only: [:edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    @messages = Message.all.page(params[:page]).per(10)
    if is_admin?
      render template: "admin/message_index"
    end 
  end

  def new
    @message = Message.new
    @junior_enterprises = JuniorEnterprise.all
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
    @message = Message.new(message_params)    
    @message.junior_enterprise_id = params[:id]    
    @message.read = false

    respond_to do |format|
      if @message.save
        if is_admin?
          UserNotifier.send_message(@message).deliver
          format.html { redirect_to "/admin/messages"}
        else
          UserNotifier.send_message(@message).deliver
          format.html { redirect_to "/junior_enterprise/#{@message.junior_enterprise_id}"}
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        if is_admin?          
          format.html { redirect_to "/admin/messages"}
        end
      else
        format.html { render :edit }
      end
    end
  end


  def destroy
    @message.destroy
    respond_to do |format|
      if is_admin?        
        format.html { redirect_to "/admin/messages" }
      else        
        format.html { redirect_to "/dashboard" }
      end
    end
  end

  private
    def set_message
      if is_admin?
        @message = Message.find(params[:id])
      end
    end


    def message_params
      params.require(:message).permit(:name, :email, :text, :phone)
    end
end
