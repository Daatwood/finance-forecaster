class UserMailer < ActionMailer::Base
  include Devise::Mailers::Helpers

  default from: "contact@ryknzu.com"

  def confirmation_instructions(record)
    devise_mail(record, :confirmation_instructions)
  end

  def reset_password_instructions(record,token,options)
    devise_mail(record, :reset_password_instructions)
  end

  def unlock_instructions(record)
    devise_mail(record, :unlock_instructions)
  end

  def invitation_instructions(record, token, opts={})
    @token = token
    devise_mail(record, :invitation_instructions, opts)
  end

  # you can then put any of your own methods here
end