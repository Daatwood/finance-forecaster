class NotificationMailer < ActionMailer::Base
    default :from => "contact@ryknzu.com"

  def post_email(message)
   mail(:to => "#{message.to}",
   :subject => "New Message",
      :body => "From: #{message.from}\nMessage: #{message.subject}\n#{message.body}")
  end
end
