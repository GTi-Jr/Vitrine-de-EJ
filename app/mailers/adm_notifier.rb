class AdmNotifier < ActionMailer::Base
  default :from => 'vitrinedeej@brasiljunior.com'

  def send_feedback(message)
    @message = message
    mail( :to => ADM_EMAIL,
    :subject => 'Feedback - Vitrine de EJ' )
  end
end
