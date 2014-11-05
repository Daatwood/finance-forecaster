class BanksController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!
  before_action :set_bank, only: [:show, :edit, :update, :destroy]

  def index
    @banks = current_user.banks
    @bank = Bank.new
    respond_with(@banks)
  end

  def show
    @transaction = Transaction.new
    @transactions = @bank.transactions
    @bills = current_user.bills
    respond_with(@bank)
  end

  def new
    @bank = Bank.new
    respond_with(@bank)
  end

  def edit
  end

  def create
    @bank = current_user.banks.new(bank_params)
    @bank.save
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

    def bank_params
      params.require(:bank).permit(:name,:balance,:color)
    end
end
