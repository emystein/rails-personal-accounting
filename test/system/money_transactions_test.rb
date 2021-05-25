require "application_system_test_case"

class MoneyTransactionsTest < ApplicationSystemTestCase
  setup do
    @money_transaction = money_transactions(:one)
  end

  test "visiting the index" do
    visit money_transactions_url
    assert_selector "h1", text: "Money Transactions"
  end

  test "creating a Money transaction" do
    visit money_transactions_url
    click_on "New Money Transaction"

    fill_in "Amount", with: @money_transaction.amount
    fill_in "Savings account", with: @money_transaction.savings_account_id
    click_on "Create Money transaction"

    assert_text "Money transaction was successfully created"
    click_on "Back"
  end
end
