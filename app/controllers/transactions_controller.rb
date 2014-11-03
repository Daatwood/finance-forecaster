class TransactionsController < ApplicationController
  respond_to :html, :js, :json
  before_action :authenticate_user!
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  def index
    @transactions = Transaction.all
    respond_with(@transactions)
  end

  def show
    respond_with(@transaction)
  end

  def new
    @transaction = Transaction.new
    respond_with(@transaction)
  end

  def edit
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.save
    respond_with(@transaction)
  end

  def update
    @transaction.update(transaction_params)
    respond_with(@transaction)
  end

  def destroy
    @transaction.destroy
    respond_with(@transaction)
  end

  private
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.require(:transaction).permit(:bill_id, :date, :summary, :amount, :bank_id)
    end
end
