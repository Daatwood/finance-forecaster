# frozen_string_literal: true

class UserMailer < ActionMailer::Base
  include Devise::Mailers::Helpers

  default from: "Finance Forecaster <#{ENV['OUTBOUND_EMAIL_ADDRESS']}>"

  def confirmation_instructions(record)
    devise_mail(record, :confirmation_instructions)
  end

  def reset_password_instructions(record, token, _options)
    @token = token
    devise_mail(record, :reset_password_instructions)
  end

  def unlock_instructions(record)
    devise_mail(record, :unlock_instructions)
  end

  def invitation_instructions(record, token, opts = {})
    @token = token
    devise_mail(record, :invitation_instructions, opts)
  end

  # you can then put any of your own methods here
end
