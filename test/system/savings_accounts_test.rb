require "application_system_test_case"

class SavingsAccountsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)

    sign_in @user

    @savings_account = savings_accounts(:user1_ars_account)
  end

  test "visiting the index" do
    visit savings_accounts_url
    assert_selector "h1", text: "Savings Accounts"
  end

  test "creating a Savings account" do
    visit savings_accounts_url
    click_on "New Savings Account"

    fill_in "Currency", with: @savings_account.currency
    fill_in "User", with: @savings_account.user_id
    click_on "Create Savings account"

    assert_text "Savings account was successfully created"
  end

  test "updating a Savings account" do
    visit savings_accounts_url
    click_on "Edit", match: :first

    fill_in "Currency", with: @savings_account.currency
    fill_in "User", with: @savings_account.user_id
    click_on "Update Savings account"

    assert_text "Savings account was successfully updated"
  end
end
