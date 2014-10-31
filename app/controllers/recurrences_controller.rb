class RecurrencesController < ApplicationController
  before_action :set_recurrence, only: [:show, :edit, :update, :destroy]

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
    @recurrence.update(recurrence_params)
    respond_with(@recurrence)
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
      params[:recurrence]
    end
end
