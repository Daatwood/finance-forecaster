class WelcomeController < ApplicationController

  def index
    if current_user
      redirect_to dashboard_path
    end
  end

  def demo
    demo = User.find_by_public(true)
    sign_out(current_user) if current_user
    sign_in(:user, demo, bypass: true)
    redirect_to dashboard_path, notice: "You are viewing demo."
  end
  
  def end_demo
    sign_out(current_user)
    redirect_to root_url, notice: 'No longer viewing demo.'
  end

  # # GET Let user resend invitation
  # def reinvite

  # end

  # # PUT resend user invitation
  # def invite
  #   user = User.invitation_not_accepted.where(email: params[:email]).first
  #   user.deliver_invitation unless user.nil?
  #   respond_to do |format|
  #     if user
  #       format.html { redirect_to(root_url, notice: 'You will receive an email with invitation instructions in a few minutes.') }
  #     else
  #       flash[:error] = "Invitation could not be sent."
  #       format.html { redirect_to(root_url) }
  #     end
  #   end
  # end

end
