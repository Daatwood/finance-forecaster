# frozen_string_literal: true

class TransactionsController < ApplicationController
  respond_to :html, :js, :json
  before_action :authenticate_user!
  before_action :new_transaction, only: %i[index new]
  before_action :set_transaction, only: %i[show edit update destroy]

  def index
    @bank = current_user.bank
    @transactions = current_user.transactions.order(date: :desc)
    respond_with(@transactions)
  end

  def create
    tparams = transaction_params
    @bank = current_user.bank
    if tparams[:summary] == 'Readjustment'
      new_balance = tparams.delete(:amount).to_i
      tparams[:amount] = new_balance - @bank.balance
    elsif tparams[:amount].to_i == 0
      flash[:warning] = "Unable to create transaction with amount of '#{tparams[:amount]}'."
      redirect_to :back && return
    end
    @transaction = @bank.transactions.new(tparams)

    if @transaction.save
      @bank.update(balance: @bank.balance + @transaction.amount)
    end
    flash[:notice] = "Added transaction for $#{@transaction.amount}. Balance updated."
    respond_with(@transaction)
  end

  def update
    updated = @transaction.update(transaction_params)
    respond_to do |format|
      if updated
        format.html { redirect_to(dashboard_path, notice: 'Transaction update.') }
        format.json { respond_with_bip(@transaction) }
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip(@transaction) }
      end
    end
  end

  def destroy
    flash[:notice] = 'Transaction deleted.' if @transaction.destroy

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
