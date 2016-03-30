module API
  module V1
    class Dashboard < Grape::API
      version 'v1'
      format :json

      resource :dashboard do
        # curl -d "token=Bz8xVtfobLskA5SVmVuH" --request GET http://localhost:3000/api/v1/dashboard
        desc "return list of payments"
        get do
          #@bank = @user.banks.find(params:[:id])
          CalculateDashboardData.call(@user.banks.first, 2)
        end

      end

    end
  end
end
