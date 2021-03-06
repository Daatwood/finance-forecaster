# frozen_string_literal: true

class BillsController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!
  before_action :new_bill, only: [:index]
  before_action :set_bill, only: %i[show edit update destroy]

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

  def edit; end

  def create
    @bill = current_user.bank.bills.new(bill_params)
    @bill.recurrences.new(recurrence_params)
    @bill.save
    respond_with(@bill)
  end

  def update
    @recurrence = Recurrence.new
    @exclusion = Exclusion.new
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to(@bill, notice: 'Bill update.') }
        format.json { respond_with_bip(@bill) }
      else
        format.html { render action: 'show' }
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
      :website
    )
  end

  def recurrence_params
    params['bill'].require(:recurrences_attributes).permit(
      :id,
      :frequency,
      :expires_at,
      :interval,
      :active_at,
      :amount,
      :note
    )
  end
end
