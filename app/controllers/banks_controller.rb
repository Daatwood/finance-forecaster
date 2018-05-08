class BanksController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!
  before_action :set_bank, only: [:show, :edit, :update, :destroy]

  def index
    @bank = current_user.bank || current_user.bank.new
    respond_with(@bank)
  end

  def show
    respond_with(@bank)
  end

  def new
    @bank = current_user.bank.new
    respond_with(@bank)
  end

  def edit
  end

  def create
    params = new_bank_params
    @bank = current_user.bank.new(params)
    if @bank.save
      transaction = @bank.transactions.create(amount: params[:balance], date: DateTime.now, summary: "Initial Balance")
      transaction.save
    end
    respond_with(@bank)
  end

  def update
    @bank.update(bank_params)
    respond_with(@bank)
  end

  def destroy
    @bank.destroy
    respond_with(@bank)
  end

  private
    def set_bank
      @bank = Bank.find(params[:id])
    end

    def new_bank_params
      params.require(:bank).permit(:name,:balance,:color)
    end

    def bank_params
      params.require(:bank).permit(:name,:color)
    end
end
