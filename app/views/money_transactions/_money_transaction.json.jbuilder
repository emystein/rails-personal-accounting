json.extract! money_transaction, :id, :savings_account_id, :date, :direction, :amount, :created_at, :updated_at
json.url money_transaction_url(money_transaction, format: :json)
