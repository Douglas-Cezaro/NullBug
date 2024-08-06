class TransactionsController < ApplicationController
  before_action :set_account

  VALID_TRANSACTION_TYPES = ['debit', 'credit'].freeze

  def create
    if transaction_params_present?
      if valid_transaction_type?
        transaction = @account.transactions.new(transaction_params)

        if transaction.save
          render json: {
            account: AccountSerializer.new(@account).serializable_hash,
            previous_balance: @account.balance - transaction.amount,
            new_balance: @account.balance
          }, status: :created
        else
          render json: { errors: transaction.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Invalid transaction_type. Please provide a valid type: debit or credit.' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Transaction parameters are missing or empty. Please provide all required fields.' }, status: :unprocessable_entity
    end
  end

  def index
    transactions = @account.transactions

    render json: {
      account: AccountSerializer.new(@account).serializable_hash,
      transactions: TransactionSerializer.new(transactions).serializable_hash,
      balance: @account.balance
    }
  end

  private

  def set_account
    @account = Account.find(params[:account_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Account not found' }, status: :not_found
  end

  def transaction_params
    params.require(:transaction).permit(:transaction_type, :amount)
  end

  def transaction_params_present?
    params[:transaction].present? && params[:transaction][:transaction_type].present? && params[:transaction][:amount].present?
  end

  def valid_transaction_type?
    VALID_TRANSACTION_TYPES.include?(params[:transaction][:transaction_type])
  end
end
