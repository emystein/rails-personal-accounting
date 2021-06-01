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

    assert @savings_account.balance == 10
  end

  test 'withdraw' do
    post withdraw_savings_account_url(@savings_account), params: { savings_account: { currency: @savings_account.currency, user_id: @savings_account.user_id },
                                                                   amount: 10,
                                                                   description: 'a withdrawal' }

    assert @savings_account.balance == -10
  end


  test 'exchange money' do
    usd_account = savings_accounts(:user1_usd_account)
    usd_account.credit(100)

    post exchange_money_savings_account_url(@savings_account), params: { savings_account: { currency: @savings_account.currency, user_id: @savings_account.user_id },
                                                                    source_currency: 'USD',
                                                                    amount_in_source_currency: 100,
                                                                    to_target_exchange_rate: 100
                                                                  }
    assert_equal 10_000, @savings_account.balance
    assert_equal 0, usd_account.balance
  end
end
