class AccountsController < ApplicationController
  respond_to :html
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def index
    @accounts = current_user.accounts
    respond_with(@accounts)
  end

  def show
    respond_with(@account)
  end

  def new
    @account = Account.new
    respond_with(@account)
  end

  def edit
  end

  def create
    @account = current_user.accounts.new(account_params)
    flash[:notice] = "Account was successfully created." if @account.save
    respond_with(@account)
  end

  def update
    @account.update(account_params)
    respond_with(@account)
  end

  def destroy
    @account.destroy
    respond_with(@account)
  end

  private
    def set_account
      @account = Account.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:name,:phone,:address,:account_number,:website)
    end
end
