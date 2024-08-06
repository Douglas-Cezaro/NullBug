class TransactionSerializer
  include JSONAPI::Serializer

  attributes :transaction_type, :amount, :created_at
end