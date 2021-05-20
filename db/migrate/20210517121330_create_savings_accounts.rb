class CreateSavingsAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :savings_accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :currency

      t.timestamps
    end
  end
end
