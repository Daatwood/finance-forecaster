class DashboardController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!
  before_action :set_recurrence, only: [:skip_payment, :mark_paid]
  before_action :set_bank, only: [:skip_payment, :mark_paid]

  def index
    @bills = current_user.bills
    @transaction = current_user.bank.transactions.new
    unless @bills.blank?
      @forecast = ForecastTransactions.call(current_user)
      @chart_data = CalculateBalanceChart.call(@forecast)
    end
  end

  # POST skip_payment?[:recurrence_id,:date]
  def skip_payment
    if (@recurrence.once? && @recurrence.active_at.to_date.to_s == params[:date])
      @recurrence.update(active_at: @recurrence.next_date)
    else
      @exclusion = @recurrence.bill.exclusions.create(date: params[:date])
    end
    respond_to do |format|
      format.js {render action: 'success'}
    end
  end

  # POST mark_paid?[:recurrence_id,:date,:amount]
  def mark_paid
    if (@recurrence.once? || @recurrence.active_at.to_date.to_s != params[:date])
      @exclusion = @recurrence.bill.exclusions.new(date: params[:date])
    end
    # Create transaction with amount
    @transaction = current_user.bank.transactions.new(transaction_params)
    if (@transaction.save)
      @recurrence.update(active_at: @recurrence.next_date) unless @exclusion
      @exclusion.save if @exclusion
      @bank.update(balance: @bank.balance + @transaction.amount)
    end
    respond_to do |format|
      format.js {render action: 'success'}
    end
  end

  private

  def set_bank
    @bank = current_user.bank
  end

  def set_recurrence
    @recurrence = current_user.recurrences.find(params[:recurrence_id])
    @row_id = "#{params[:date]}_#{params[:recurrence_id]}" 
    @balance = current_user.bank.balance
  end

  def transaction_params
    summary = @recurrence.bill.summary
    summary += " (#{@recurrence.note})" if @recurrence.note.present?
    params.permit(:date, :amount).merge({summary: summary})
  end

end
