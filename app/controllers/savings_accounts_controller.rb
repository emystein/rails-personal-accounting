class SavingsAccountsController < ApplicationController
  before_action :set_savings_account, only: %i[ show edit update destroy ]

  # GET /savings_accounts or /savings_accounts.json
  def index
    @savings_accounts = SavingsAccount.all
  end

  # GET /savings_accounts/1 or /savings_accounts/1.json
  def show
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

  def new_deposit

  end

  def deposit
    @savings_account = SavingsAccount.find(params[:id])
    @savings_account.money_transactions.new(direction: 'deposit', amount: params[:amount])
    @savings_account.save
    redirect_to @savings_account, notice: 'Money has been deposited.'
  end

  def new_withdrawal

  end

  def withdraw
    @savings_account = SavingsAccount.find(params[:id])
    @savings_account.money_transactions.new(direction: 'withdrawal', amount: params[:amount])
    @savings_account.save
    redirect_to @savings_account, notice: 'Money has been withdrawn.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_savings_account
      @savings_account = SavingsAccount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def savings_account_params
      params.require(:savings_account).permit(:user_id, :currency)
    end
end