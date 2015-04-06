class WelcomeController < ApplicationController

  def index
    if user_signed_in?
      redirect_to dashboard_path
      return
    end
  end

  # GET Let user resend invitation
  def reinvite

  end

  # PUT resend user invitation
  def invite
    user = User.invitation_not_accepted.where(email: params[:email]).first
    user.deliver_invitation unless user.nil?
    respond_to do |format|
      if user
        format.html { redirect_to(root_url, notice: 'You will receive an email with invitation instructions in a few minutes.') }
      else
        flash[:error] = "Invitation could not be sent."
        format.html { redirect_to(root_url) }
      end
    end
  end

end
