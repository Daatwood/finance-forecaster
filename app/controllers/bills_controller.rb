class BillsController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  def index
    @bank = current_user.bank
    @bills = current_user.bills.order(:summary)
    @bill = @bank.bills.new
    
    respond_with(@bills)
  end

  def show
    @transaction = Transaction.new
    
    @recurrences = @bill.recurrences.order(:active_at)
    @recurrence = Recurrence.new
    @exclusions = @bill.exclusions
    @exclusion = Exclusion.new
    @bank = current_user.bank
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
      params.require(:bill).permit( :summary, 
                                    :bill_type, 
                                    :bank_id, 
                                    :color, 
                                    :website, 
                                    recurrences: [:frequency, 
                                                  :expires_at, 
                                                  :interval, 
                                                  :active_at, 
                                                  :amount, 
                                                  :note])
    end
end
