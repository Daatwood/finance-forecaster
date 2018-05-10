class TransactionsController < ApplicationController
  respond_to :html, :js, :json
  before_action :authenticate_user!
  before_action :new_transaction, only: [:index, :new]
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  def index
    @transactions = current_user.transactions
    respond_with(@transactions)
  end

  def create
    tparams = transaction_params
    if tparams[:amount].to_i != 0
      balance = current_user.bank.balance
      if tparams[:summary] == "Readjustment"
        new_balance = tparams.delete(:amount).to_i
        tparams[:amount] = new_balance - balance
      end
      @transaction = current_user.bank.transactions.new(tparams)
      @transaction.save
      flash[:notice] = "Added transaction for $#{@transaction.amount}. Balance updated."
    else
      flash[:warning] = "Unable to create transaction with amount of '#{tparams[:amount]}'."
    end

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
    if @transaction.destroy
      flash[:notice] = 'Transaction deleted.'
    end

    respond_with(@transaction)
  end

  private

  def new_transaction
    @transaction = current_user.transactions.new
  end

  def set_transaction
    @transaction = current_user.transactions.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:id, :date, :summary, :amount, :bank_id)
  end
end
