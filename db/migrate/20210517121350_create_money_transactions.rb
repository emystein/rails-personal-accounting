class CreateMoneyTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :money_transactions do |t|
      t.references :savings_account, null: false, foreign_key: true
      t.datetime :date
      t.string :direction
      t.integer :amount

      t.timestamps
    end
  end
end
