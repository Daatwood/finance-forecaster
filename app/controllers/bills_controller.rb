class BillsController < ApplicationController
  respond_to :html
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  def index
    @bills = current_user.bills
    respond_with(@bills)
  end

  def show
    @recurrences = @bill.recurrences
    @recurrence = Recurrence.new
    @logicals = @bill.create_logical_payments
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
    @bill.update(bill_params)
    @bill.recurrences.where(static_amount: false).update_all(amount: @bill.amount)
    respond_with(@bill)
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
      params.require(:bill).permit(:summary,:amount,:bill_type,:account_id, :bank_id)
    end
end
