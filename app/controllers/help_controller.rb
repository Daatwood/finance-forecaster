class HelpController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!

  def index
    @public_users = User.where(public: true)
  end

  def show
    example_user = User.find(params[:id])
    if example_user
      cookies.signed[:example_user_id] = example_user.id
    else
      cookies.delete :example_user_id
    end

    respond_to do |format|
      if example_user
        format.html { redirect_to(dashboard_path, notice: "Viewing as #{example_user.email}.") }
      else
        format.html { redirect_to(help_path, notice: "Unable to viewing #{example_user.email}.") }
      end
    end
  end

end
