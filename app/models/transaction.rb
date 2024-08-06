class Transaction < ApplicationRecord
  belongs_to :account
  validates :transaction_type, inclusion: { in: %w[credit debit] }
  after_create :update_account_balance

  private

  def update_account_balance
    if transaction_type == 'credit'
      account.update(balance: account.balance + amount)
    elsif transaction_type == 'debit'
      account.update(balance: account.balance - amount)
    end
  end
end