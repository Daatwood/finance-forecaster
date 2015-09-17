module API
  module V1
    class Recurrences < Grape::API
      version 'v1'
      format :json

      resource :recurrences do
        # curl -d "token=TOKEN" --request GET http://localhost:3000/api/v1/recurrences
        desc "return list of recurrences"
        params do
          requires :bill_id, type: String
        end
        get do
          @user.bills.find(params[:bill_id]).recurrences.order(:active_at)
        end

        # curl -d "token=TOKEN&name=NAME" --request POST http://localhost:3000/api/v1/recurrences
        desc "create a new recurrence"
        params do
          requires :bill_id, type: String
          requires :active, type: String
          optional :expires, type: String
          requires :frequency, type: String
          optional :interval, type: String
          requires :amount, type: String
        end
        post do
          error!("Frequency must be ONCE,DAILY,WEEKLY,MONTHLY,YEARLY", 400) unless ["ONCE","DAILY","WEEKLY","MONTHLY","YEARLY"].include? params[:frequency]
          params[:interval] = 1 if params[:interval].blank?
          Recurrence.create!({bill_id:params[:bill_id], active_at:params[:active], expires_at:params[:expire], frequency:params[:frequency], interval:params[:interval], amount:params[:amount]})
        end

        # curl -d "token=TOKEN" --request DELETE http://localhost:3000/api/v1/recurrences/:id
        desc "delete a recurrence"
        params do
          requires :id, type: String
          requires :bill_id, type: String
        end
        delete ':id' do
          @user.bills.find(params[:bill_id]).recurrences.find(params[:id]).delete
        end

        desc "update a recurrence"
        params do
          requires :id, type: String
          requires :bill_id, type: String
          optional :active, type: String
          optional :expire, type: String
          optional :frequency, type: String
          optional :interval, type: String
          optional :amount, type: String
        end
        put ':id' do
          if params[:frequency]
            error!("Frequency must be ONCE,DAILY,WEEKLY,MONTHLY,YEARLY", 400) unless ["ONCE","DAILY","WEEKLY","MONTHLY","YEARLY"].include? params[:frequency]
          end
          @user.bills.find(params[:bill_id]).recurrences.find(params[:id]).update({active:params[:active], expire:params[:expire], frequency:params[:frequency], interval:params[:interval], amount:params[:amount]})
          @user.bills.find(params[:bill_id]).recurrences.find(params[:id])
        end

      end

    end
  end
end
