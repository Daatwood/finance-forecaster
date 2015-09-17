module API
  module V1
    class Accounts < Grape::API
      version 'v1'
      format :json

      resource :accounts do
        # curl -d "token=TOKEN" --request GET http://localhost:3000/api/v1/accounts
        desc "return list of accounts"
        get do
          @user.accounts
        end

        # curl -d "token=TOKEN&name=NAME" --request POST http://localhost:3000/api/v1/accounts
        desc "create a new account"
        params do
          requires :name, type: String
        end
        post do
          @user.accounts.create!({name:params[:name]})
        end

        # curl -d "token=TOKEN" --request DELETE http://localhost:3000/api/v1/accounts/:id
        desc "delete a account"
        params do
          requires :id, type: String
        end
        delete ':id' do
          @user.accounts.find(params[:id]).delete
        end

        # curl -d "token=TOKEN&name=NAME" --request PUT http://localhost:3000/api/v1/accounts/:id
        desc "update an account name"
        params do
          requires :id, type: String
          requires :name, type: String
        end
        put ':id' do
          @user.accounts.find(params[:id]).update({name:params[:name]})
          @user.accounts.find(params[:id])
        end

      end

    end
  end
end
