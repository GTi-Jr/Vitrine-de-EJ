class UserNotifier < ActionMailer::Base
    default :from => 'vitrinedeej@brasiljunior.com'

  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for our amazing app' )
  end

  def send_recover_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for our amazing app' )
  end 

  def send_message(message)
    @message = message
    @je = JuniorEnterprise.find(@message.junior_enterprise_id)
    @user = User.find(@je.user_id)

    mail( :to => @user.email,
    :subject => 'Menssagem' )
  end
end
