module API
  module V1
    class Dashboard < Grape::API
      version 'v1'
      format :json

      resource :dashboard do
        desc "return list of payments"
        get do
          CalculateDashboardData.call(@user.banks.first, 2)
        end

      end

    end
  end
end
