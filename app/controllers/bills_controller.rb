class BillsController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!
  before_action :new_bill, only: [:index]
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  def index
    @bills = current_user.bills.order(:summary)
    @bill = new_bill
    
    respond_with(@bills)
  end

  def show
    @transaction = Transaction.new
    
    @recurrences = @bill.recurrences.order(:active_at)
    @recurrence = Recurrence.new
    @exclusions = @bill.exclusions
    @exclusion = Exclusion.new
    respond_with(@bill)
  end

  def new
    @bill = new_bill

    respond_with(@bill)
  end

  def edit
  end

  def create
    @bill = current_user.bank.bills.new(bill_params)
    @bill.recurrences.new(recurrence_params)
    @bill.save
    puts @bill.errors.inspect
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
    def new_bill
      @bill = current_user.bank.bills.new
      @bill.recurrences.build
      @bill
    end

    def set_bill
      @bill = current_user.bills.find(params[:id])
    end

    def bill_params
      params.require(:bill).permit( 
        :id,
        :summary, 
        :bill_type, 
        :bank_id, 
        :color, 
        :website)
        # recurrences_attributes: [
        #   :id,
        #   :frequency, 
        #   :expires_at, 
        #   :interval, 
        #   :active_at, 
        #   :amount, 
        #   :note])
    end

    def recurrence_params
      params["bill"].require(:recurrences_attributes).permit( 
        :id,
        :frequency, 
        :expires_at, 
        :interval, 
        :active_at, 
        :amount, 
        :note)
    end
end
