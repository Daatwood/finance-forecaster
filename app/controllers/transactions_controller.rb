class TransactionsController < ApplicationController
  respond_to :html, :js, :json
  before_action :authenticate_user!
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  def index
    @transactions = current_user.transactions
    respond_with(@transactions)
  end

  def show
    respond_with(@transaction)
  end

  def new
    @transaction = current_user.bank.transactions.new
    respond_with(@transaction)
  end

  def edit
  end

  def create
    params = transaction_params
    if params[:summary] == "Readjustment"
      bank = Bank.find(params[:bank_id])
      new_balance = params.delete(:amount).to_i
      params[:amount] = new_balance - bank.balance
    end

    @transaction = Transaction.new(params)
    @transaction.save
    respond_with(@transaction)
  end

  def update
    updated = @transaction.update(transaction_params)
    respond_to do |format|
      if updated
        format.html { redirect_to(dashboard_path, notice: 'Transaction update.') }
        format.json { respond_with_bip(@transaction) }
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip(@transaction) }
      end
    end
  end

  def destroy
    @transaction.destroy
    redirect_to(dashboard_path, notice: 'Transaction deleted.')
  end

  private
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.require(:transaction).permit(:bill_id, :date, :summary, :amount, :bank_id, {:exclusion => []} )
    end
end
