require 'application_system_test_case'

class ExchangeCurrenciesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @ars_account = savings_accounts(:user1_ars_account)
    @usd_account = savings_accounts(:user1_usd_account)
  end

  test 'exchange USD to ARS' do
    @usd_account.credit(Money.from_amount(100, 'USD'))

    visit new_exchange_currency_url

    select 'USD', from: 'currency_to_sell'
    fill_in 'Amount to sell', with: 100
    select 'ARS', from: 'currency_to_buy'
    fill_in 'Exchange rate', with: 100

    click_on 'Submit'

    assert_equal Money.from_amount(10_000, 'ARS'), @ars_account.balance
  end
end