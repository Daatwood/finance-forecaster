module API
  class Root < Grape::API
    prefix 'api'
    format :json
    default_format :json

    rescue_from :all, backtrace: true
    error_formatter :json, API::ErrorFormatter

    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    helpers do
      def warden
        env['warden']
      end

      def authenticated
        return true if warden.authenticated?
        params[:token] && @user = User.find_by_authentication_token(params[:token])
      end

      def current_user
        warden.user || @user
      end
    end

    mount API::V1::Root
  end
end
