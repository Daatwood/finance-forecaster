class MessagesController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!
  before_action :no_visitors!
  before_action :set_message, only: [:show, :destroy]

  def index
    @message = Message.new(from: current_user.email)
    @messages = Message.where(to: current_user.email).order(:updated_at)
    respond_with(@messages)
  end

  def show
    @response = Message.new(from: current_user.email, to: @message.from)
    respond_with(@message)
  end

  def new
    @message = Message.new()
  end

  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to(messages_path, notice: 'Message sent.') }
      else
        flash[:error] = "Message could not be sent."
        format.html { redirect_to(messages_path) }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @message.destroy
        format.html { redirect_to(messages_path, notice: 'Message deleted.') }
      else
        flash[:error] = "Message could not be deleted."
        format.html { redirect_to(messages_path) }
      end
    end
  end

  protected
    def no_visitors!
      if @example_user
        flash[:error] = 'Unable to view Messages while viewing an example.'
        redirect_to(root_path)
        return
      end
    end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:to,:from,:subject,:body)
    end

end
