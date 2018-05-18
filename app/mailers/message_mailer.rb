class MessageMailer < ActionMailer::Base

  default :to => "Finance Forecaster <contact@finance-forecaster.com>"

  def contact(message)
    @message = message
    mail(from: @message.email, subject: 'New Finance Forecaster Message')
  end

end