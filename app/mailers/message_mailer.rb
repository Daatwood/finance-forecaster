# frozen_string_literal: true

class MessageMailer < ActionMailer::Base
  default to: "Finance Forecaster <#{ENV['INBOUND_EMAIL_ADDRESS']}>"
  default from: "Finance Forecaster <#{ENV['OUTBOUND_EMAIL_ADDRESS']}>"

  def contact(message)
    @message = message
    mail(subject: 'New Finance Forecaster Message')
  end
end
