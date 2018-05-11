class WelcomeController < ApplicationController

  def index
    if current_user
      redirect_to dashboard_path
    end
    set_demo_user
  end

  def demo
    set_demo_user
    sign_out(current_user) if current_user
    if (@demo_user)
      sign_in(:user, @demo_user, bypass: true)
      redirect_to dashboard_path, notice: "You are viewing demo."
    else
      redirect_to root_path, warning: "Unable to access demo account. Try again later." 
    end
  end
  
  def end_demo
    sign_out(current_user)
    redirect_to root_url, notice: 'No longer viewing demo.'
  end

  private

  def set_demo_user
    @demo_user = User.find_by_public(true)
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
