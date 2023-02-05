require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @savings_account = savings_accounts(:user1_ars_account)
  end

  test 'visit user profile' do
    visit profile_url

    assert_selector 'h1', text: 'Savings Accounts'
  end

  test 'from user profile navigate to deposit' do
    visit profile_url

    click_link 'Deposit', :match => :first

    assert_selector 'h1', text: 'Deposit'
    assert_text 'Amount'
    assert_text 'Description'
  end

  test 'from user profile navigate to withdraw' do
    visit profile_url

    click_link 'Withdraw', :match => :first

    assert_selector 'h1', text: 'Withdraw'
    assert_text 'Amount'
    assert_text 'Description'
  end

  test 'from user profile navigate to sell' do
    visit profile_url

    click_link 'Sell', :match => :first

    assert_selector 'h1', text: 'Exchange Currency'
    assert_select 'Currency to sell'
    assert_text 'Amount to sell'
    assert_select 'Currency to buy'
    assert_text 'Exchange rate'
  end
end
