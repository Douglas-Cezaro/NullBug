class AccountsController < ApplicationController
  def create
    if params[:account].present?
      account = Account.new(account_params)
      account.balance = 0
      account.password = SecureRandom.hex(8)
  
      if account.save
        render json: {
          account: AccountSerializer.new(account).serializable_hash,
          password: account.password
        }, status: :created
      else
        render json: { errors: account.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'The account parameter is missing. Please provide the account details in the request body under the key "account".' }, status: :unprocessable_entity
    end
  end

  def show
    begin
      account = Account.find(params[:id])
      render json: AccountSerializer.new(account).serializable_hash.to_json
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Account not found' }, status: :not_found
    end
  end

  private
  
  def account_params
    params.require(:account).permit(:name, :birth_date, :document)
  end
end
