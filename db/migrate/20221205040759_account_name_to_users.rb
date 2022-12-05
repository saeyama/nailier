class AccountNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :account_name, :string, null: false
    add_index :users, :account_name, unique: true
  end
end
