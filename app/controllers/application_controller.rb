class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_action :set_viewing_as

  # def after_sign_in_path_for(resource_or_scope)
  #   # return home_page_path for user using current_user method
  #   if resource.is_a?(User)
  #     user_root_path(resource)
  #   else
  #     super
  #   end
  # end

  protected
  
  def no_visitors!
    if @example_user
      flash[:error] = 'Unable to view Messages while viewing an example.'
      redirect_to(root_path)
      return
    end
  end

  # def set_viewing_as
  #   @example_user_id = cookies.signed[:example_id]
  #   @example_user = User.where(public: true).find(@example_user_id) unless @example_user_id.blank?
  # end

end
