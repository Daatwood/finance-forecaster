class MessageMailer < ActionMailer::Base

  default :to => "Finance Forecaster <contact@finance-forecaster.com>"
  default :from => "Finance Forecaster <notifications@finance-forecaster.com>"

  def contact(message)
    @message = message
    mail(subject: 'New Finance Forecaster Message')
  end

end