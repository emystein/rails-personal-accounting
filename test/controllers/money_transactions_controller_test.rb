require "test_helper"

class MoneyTransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @money_transaction = money_transactions(:one)
  end

  test "should get index" do
    get money_transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_money_transaction_url
    assert_response :success
  end

  test "should create money_transaction" do
    assert_difference('MoneyTransaction.count') do
      post money_transactions_url, params: { money_transaction: { amount: @money_transaction.amount, savings_account_id: @money_transaction.savings_account_id } }
    end

    assert_redirected_to money_transaction_url(MoneyTransaction.last)
  end

  test "should show money_transaction" do
    get money_transaction_url(@money_transaction)
    assert_response :success
  end
end
