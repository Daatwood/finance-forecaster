class RecurrencesController < ApplicationController
  respond_to :html, :js, :json
  before_action :authenticate_user!
  before_action :set_recurrence, only: [:show, :edit, :update, :destroy, :advance]

  def index
    @recurrences = Recurrence.all
    respond_with(@recurrences)
  end

  def show
    respond_with(@recurrence)
  end

  def new
    @recurrence = Recurrence.new
    respond_with(@recurrence)
  end

  def edit
  end

  def create
    @recurrence = Recurrence.new(recurrence_params)
    @recurrence.save
    respond_with(@recurrence)
  end

  def update
    respond_to do |format|
      if @recurrence.update(recurrence_params)
        format.html { redirect_to(@recurrence, notice: 'Recurrence update.') }
        format.json { respond_with_bip(@recurrence) }
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip(@recurrence) }
      end
    end
  end

  def advance
    respond_to do |format|
      if @recurrence.update(active_at: @recurrence.next_date)
        format.html { redirect_to(@recurrence.bill, notice: 'Recurrence update.') }
        format.json { respond_with_bip(@recurrence) }
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip(@recurrence) }
      end
    end
  end

  def destroy
    @recurrence.destroy
    respond_with(@recurrence)
  end

  private
    def set_recurrence
      @recurrence = Recurrence.find(params[:id])
    end

    def recurrence_params
      params.require(:recurrence).permit(:bill_id,:frequency,:interval,:active_at,:expires_at,:static_amount,:amount,:note)
    end
end
