require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'when register user create default accounts' do
    post '/users', params: { user: { email: "user@example.org", password: "password", password_confirmation: "password" } }

    user = User.find_by(email: 'user@example.org')

    ars_account = user.account_for_currency('ARS')
    assert_not_nil ars_account

    usd_account = user.account_for_currency('USD')
    assert_not_nil usd_account
  end
end

