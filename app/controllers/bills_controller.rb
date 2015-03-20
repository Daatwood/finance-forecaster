class BillsController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  def index
    @bills = current_user.bills.order(:summary)
    @accounts = current_user.accounts
    @bill = Bill.new
    @banks = current_user.banks
    respond_with(@bills)
  end

  def show
    @transaction = Transaction.new
    @recurrences = @bill.recurrences
    @recurrence = Recurrence.new
    @exclusions = @bill.exclusions
    @exclusion = Exclusion.new
    @banks = current_user.banks
    @transactions = current_user.transactions.where(bill_id: @bill.id)
    respond_with(@bill)
  end

  def new
    @bill = Bill.new
    @accounts = current_user.accounts
    @banks = current_user.banks
    respond_with(@bill)
  end

  def edit
    @banks = current_user.banks
  end

  def create
    @bill = Bill.new(bill_params)
    @bill.save
    respond_with(@bill)
  end

  def update
    updated = @bill.update(bill_params)
    @bill.recurrences.where(static_amount: false).update_all(amount: @bill.amount) if updated
    respond_to do |format|
      if updated
        format.html { redirect_to(@bill, notice: 'Bill update.') }
        format.json { respond_with_bip(@bill) }
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip(@bill) }
      end
    end
  end

  def destroy
    @bill.destroy
    respond_with(@bill)
  end

  private
    def set_bill
      @bill = Bill.find(params[:id])
    end

    def bill_params
      params.require(:bill).permit(:summary,:amount,:bill_type,:account_id, :bank_id, :color)
    end
end
