# frozen_string_literal: true

class ContactController < ApplicationController
  def index
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    

    respond_to do |format|
      if verify_recaptcha(model: @message) && @message.valid?
        MessageMailer.contact(@message).deliver_now
        format.html { redirect_to(root_path, notice: 'Message was sent.') }
      else
        format.html { render action: 'index' }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :subject, :content)
  end
end
