class BillsController < ApplicationController
  respond_to :html
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  def index
    @bills = current_user.bills
    respond_with(@bills)
  end

  def show
    @recurrences = @bill.recurrences
    @recurrence = @bill.recurrences.new
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
