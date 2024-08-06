class Account < ApplicationRecord
  validates :name, :birth_date, :document, presence: true
  validates :name, uniqueness: true
  
  has_secure_password

  mount_uploader :document, DocumentUploader
  has_many :transactions
end