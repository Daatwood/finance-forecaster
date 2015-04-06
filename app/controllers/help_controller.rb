class HelpController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!

  def index
    @public_users = User.where(public: true)
  end

  # PUT help/:id
  def show
    example_user = User.where(public: true).find(params[:id])

    message = Message.new
    message.to = example_user.email
    message.from = current_user.email
    message.subject = 'Viewed your Example.'

    if message.save
      cookies.signed[:example_id] = example_user.id
      cookies.signed[:current_id] = current_user.id
      sign_out(current_user)
      sign_in(:user, example_user, bypass: true)
      flash[:notice] = "You are now viewing example #{example_user.email}."
    else
      cookies.delete :example_id
      cookies.delete :current_id
      flash[:error] = "Unable to view example #{example_user.email}."
    end

    redirect_to dashboard_path
    return;
  end

  # DELETE help/:id
  def revert_show
    unless user_signed_in?
      redirect_to root_url
      return
    end

    sign_out(current_user)
    user = User.find(cookies.signed[:current_id])
    cookies.delete :example_id
    cookies.delete :current_id
    if user
      sign_in(:user, user, bypass: true)
      flash[:notice] = "No longer viewing an example."
    else
      flash[:notice] = "Please relog back in."
    end
    redirect_to dashboard_path
    return;
  end


end
