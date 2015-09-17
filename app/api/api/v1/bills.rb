module API
  module V1
    class Bills < Grape::API
      version 'v1'
      format :json

      resource :bills do
        # curl -d "token=TOKEN" --request GET http://localhost:3000/api/v1/bills
        desc "return list of bills"
        get do
          @user.bills
        end

        # curl -d "token=TOKEN&name=NAME" --request POST http://localhost:3000/api/v1/bills
        desc "create a new bill"
        params do
          requires :bank_id, type: String
          requires :account_id, type: String
          requires :charge, type: String
          requires :summary, type: String
        end
        post do
          error!("Charge must be CREDIT or DEBIT", 400) unless ["CREDIT","DEBIT"].include? params[:charge]
          params[:color] = "##{"%06x" % (rand * 0xffffff)}"
          Bill.create!({bank_id:params[:bank_id], account_id:params[:account_id], summary:params[:summary], bill_type:params[:charge], color:params[:color]})
        end

        # curl -d "token=TOKEN" --request DELETE http://localhost:3000/api/v1/bills/:id
        desc "delete a bill"
        params do
          requires :id, type: String
        end
        delete ':id' do
          @user.bills.find(params[:id]).delete
        end

        # curl -d "token=TOKEN&summary=NAME&charge=CHARGE" --request PUT http://localhost:3000/api/v1/bills/:id
        desc "update a bill"
        params do
          requires :id, type: String
          requires :summary, type: String
          requires :charge, type: String
        end
        put ':id' do
          error!("400 Charge must be CREDIT or DEBIT", 400) unless ["CREDIT","DEBIT"].include? params[:charge]

          @user.bills.find(params[:id]).update({summary:params[:summary],bill_type:params[:charge]})
          @user.bills.find(params[:id])
        end

      end

    end
  end
end
