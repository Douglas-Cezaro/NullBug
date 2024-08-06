class AddIndexToAccountsName < ActiveRecord::Migration[6.1]
  def change
    add_index :accounts, :name, unique: true
  end
end