# frozen_string_literal: true

class ExclusionsController < ApplicationController
  respond_to :html, :js, :json
  before_action :authenticate_user!
  before_action :set_exclusion, only: %i[show edit update destroy]

  def index
    @exclusions = Exclusion.all
    respond_with(@exclusions)
  end

  def show
    respond_with(@exclusion)
  end

  def new
    @exclusion = Exclusion.new
    respond_with(@exclusion)
  end

  def edit; end

  def create
    @exclusion = Exclusion.new(exclusion_params)
    @exclusion.save
    respond_with(@exclusion)
  end

  def update
    @exclusion.update(exclusion_params)
    respond_with(@exclusion)
  end

  def destroy
    @exclusion.destroy
    redirect_to :back, notice: 'Exclusion deleted.'
  end

  private

  def set_exclusion
    @exclusion = Exclusion.find(params[:id])
  end

  def exclusion_params
    params.require(:exclusion).permit(:date, :bill_id)
  end
end
