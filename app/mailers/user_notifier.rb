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
end
