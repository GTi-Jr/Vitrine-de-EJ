class FeedbackController < ApplicationController

  def feedback
  end

  def feedback_sent
    @message = Message.new

    if params[:text] != nil
      @message.text = params[:text]
    else
      redirect_to "/"
    end

    if params[:email] != nil
      @message.email = params[:email]
    end

    respond_to do |format|
      AdmNotifier.send_feedback(@message).deliver
      format.html { redirect_to "/"}
    end
  end
end
