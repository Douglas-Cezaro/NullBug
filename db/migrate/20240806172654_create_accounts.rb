class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.date :birth_date
      t.string :document
      t.decimal :balance
      t.string :password_digest

      t.timestamps
    end
  end
end
