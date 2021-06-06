require 'test_helper'

class UnauthorizedSavingsAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @savings_account = savings_accounts(:user1_ars_account)

    MoneyTransaction.delete_all
  end

  test 'get index unauthorized should redirect to login' do
    get savings_accounts_url

    assert_redirected_to '/users/sign_in'
  end

  test 'get new unauthorized should redirect to login' do
    get new_savings_account_url

    assert_redirected_to '/users/sign_in'
  end

  test 'should create savings_account' do
    post savings_accounts_url, params: { savings_account: { currency: @savings_account.currency, user_id: @savings_account.user_id } }

    assert_redirected_to '/users/sign_in'
  end

  test 'should show savings_account' do
    get savings_account_url(@savings_account)

    assert_redirected_to '/users/sign_in'
  end

  test 'should get edit' do
    get edit_savings_account_url(@savings_account)

    assert_redirected_to '/users/sign_in'
  end

  test 'should update savings_account' do
    patch savings_account_url(@savings_account), params: { savings_account: { currency: @savings_account.currency, user_id: @savings_account.user_id } }

    assert_redirected_to '/users/sign_in'
  end

  test 'deposit' do
    post deposit_savings_account_url(@savings_account), params: { savings_account: { currency: @savings_account.currency, user_id: @savings_account.user_id },
                                                                  amount: 10,
                                                                  description: 'a deposit' }

    assert_redirected_to '/users/sign_in'
  end

  test 'withdraw' do
    post withdraw_savings_account_url(@savings_account), params: { savings_account: { currency: @savings_account.currency, user_id: @savings_account.user_id },
                                                                   amount: 15,
                                                                   description: 'a withdrawal' }

    assert_redirected_to '/users/sign_in'
  end
end
