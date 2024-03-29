require 'money'

class SavingsAccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_savings_account, only: %i[show edit update destroy deposit withdraw new_currency_sale]

  # GET /savings_accounts or /savings_accounts.json
  def index
    @savings_accounts = current_user.savings_accounts
  end

  # GET /savings_accounts/1 or /savings_accounts/1.json
  def show
    page = params[:page] ||= 1

    @money_transactions = @savings_account.money_transactions.order_desc.page(page).per(10)
  end

  # GET /savings_accounts/new
  def new
    @savings_account = SavingsAccount.new
  end

  # GET /savings_accounts/1/edit
  def edit
  end

  # POST /savings_accounts or /savings_accounts.json
  def create
    @savings_account = SavingsAccount.new(savings_account_params)

    respond_to do |format|
      if @savings_account.save
        format.html { redirect_to @savings_account, notice: "Savings account was successfully created." }
        format.json { render :show, status: :created, location: @savings_account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @savings_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /savings_accounts/1 or /savings_accounts/1.json
  def update
    respond_to do |format|
      if @savings_account.update(savings_account_params)
        format.html { redirect_to @savings_account, notice: "Savings account was successfully updated." }
        format.json { render :show, status: :ok, location: @savings_account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @savings_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /savings_accounts/1 or /savings_accounts/1.json
  def destroy
    @savings_account.destroy
    respond_to do |format|
      format.html { redirect_to savings_accounts_url, notice: "Savings account was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def deposit
    @savings_account.credit(money_of(params[:amount]))
    redirect_to :profile
  end

  def withdraw
    @savings_account.debit(money_of(params[:amount]))
    redirect_to :profile
  end

  def new_currency_sale
    redirect_to new_currency_exchange_url(currency_to_sell: @savings_account.currency)
  end

  private

  def money_of(amount)
    Money.from_amount(amount.to_d, @savings_account.currency)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_savings_account
    @savings_account = SavingsAccount.find_by(id: params[:id], user: current_user)

    raise ActionController::RoutingError, 'Not Found' if @savings_account.nil?
  end

  # Only allow a list of trusted parameters through.
  def savings_account_params
    params.require(:savings_account).permit(:user_id, :currency)
  end
end
