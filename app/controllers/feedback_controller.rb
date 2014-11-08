class FeedbackController < ApplicationController

  def feedback
  end

  def feedback_sent
    @message = Message.new

    respond_to do |format|      

      if params[:text] != nil && params[:text] != ""
        @message.text = params[:text]
        @message.email = params[:email]

        AdmNotifier.send_feedback(@message).deliver
        format.html { redirect_to "/"}
      else        
        format.html { redirect_to "/"}
      end
    end
  end
end
