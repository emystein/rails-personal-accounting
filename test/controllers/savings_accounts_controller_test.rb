require 'test_helper'

class SavingsAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @savings_account = savings_accounts(:user1_ars_account)

    MoneyTransaction.delete_all
  end

  test 'should get index' do
    get savings_accounts_url
    assert_response :success
  end

  test 'should get new' do
    get new_savings_account_url
    assert_response :success
  end

  test 'should create savings_account' do
    assert_difference('SavingsAccount.count') do
      post savings_accounts_url, params: { savings_account: { currency: @savings_account.currency, user_id: @savings_account.user_id } }
    end

    assert_redirected_to savings_account_url(SavingsAccount.last)
  end

  test 'should show savings_account' do
    get savings_account_url(@savings_account)
    assert_response :success
  end

  test 'should get edit' do
    get edit_savings_account_url(@savings_account)
    assert_response :success
  end

  test 'should update savings_account' do
    patch savings_account_url(@savings_account), params: { savings_account: { currency: @savings_account.currency, user_id: @savings_account.user_id } }
    assert_redirected_to savings_account_url(@savings_account)
  end

  test 'deposit' do
    post deposit_savings_account_url(@savings_account), params: { savings_account: { currency: @savings_account.currency, user_id: @savings_account.user_id },
                                                                  amount: 10,
                                                                  description: 'a deposit' }

    assert @savings_account.balance == Money.from_amount(10, 'ARS')
  end

  test 'withdraw' do
    @savings_account.credit(Money.from_amount(20, 'ARS'))

    post withdraw_savings_account_url(@savings_account), params: { savings_account: { currency: @savings_account.currency, user_id: @savings_account.user_id },
                                                                   amount: 15,
                                                                   description: 'a withdrawal' }

    assert @savings_account.balance == Money.from_amount(5, 'ARS')
  end
end
