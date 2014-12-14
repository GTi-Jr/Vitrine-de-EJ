class FeedbackController < ApplicationController

  def feedback
  end

  def feedback_sent    
    result = HTTParty.post("http://jeapi.herokuapp.com/feedback",
    :body => {:text => params[:text], :email => params[:email], :token => JEAPI_KEY  })

    if result.code == 200 
      redirect_to "/", notice: "Obrigado pelo Feedback"
    else
      redirect_to "/feedback", alert: "Falha ao envio do Feedback"
    end
  end
end
