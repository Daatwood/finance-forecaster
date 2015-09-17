module API
  module V1
    class Root < Grape::API
      mount API::V1::Banks
      mount API::V1::Accounts
      mount API::V1::Bills
      mount API::V1::Recurrences
    end
  end
end
