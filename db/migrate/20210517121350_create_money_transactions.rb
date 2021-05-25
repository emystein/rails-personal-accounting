class CreateMoneyTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :money_transactions do |t|
      t.references :savings_account, null: false, foreign_key: true
      t.integer :amount
      t.string :description

      t.timestamps
    end
  end
end
