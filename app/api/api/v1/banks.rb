module API
  module V1
    class Banks < Grape::API
      version 'v1'
      format :json

      resource :banks do
        # curl -d "token=TOKEN" --request GET http://localhost:3000/api/v1/banks
        desc "return list of banks"
        get do
          @user.banks
        end

        # curl -d "token=TOKEN&name=NAME" --request POST http://localhost:3000/api/v1/banks
        desc "create a new bank"
        params do
          requires :name, type: String
        end
        post do
          @user.banks.create!({name:params[:name]})
        end

        # curl -d "token=TOKEN" --request DELETE http://localhost:3000/api/v1/banks/:id
        desc "delete a bank"
        params do
          requires :id, type: String
        end
        delete ':id' do
          @user.banks.find(params[:id]).delete
        end

        # curl -d "token=TOKEN&name=NAME" --request PUT http://localhost:3000/api/v1/banks/:id
        desc "update a bank name"
        params do
          requires :id, type: String
          requires :name, type: String
        end
        put ':id' do
          @user.banks.find(params[:id]).update({name:params[:name]})
          @user.banks.find(params[:id])
        end

      end

    end
  end
end
