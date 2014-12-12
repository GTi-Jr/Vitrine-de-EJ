class FeedbackController < ApplicationController

  def feedback
  end

  def feedback_sent    
    result = HTTParty.post("http://jeapi.herokuapp.com/feedback",
    :body => {:text => params[:text], :email => params[:email], :token => JEAPI_KEY  })

    if result.code == 200 
      redirect_to "/"
    else
      redirect_to "/"
    end
  end
end
