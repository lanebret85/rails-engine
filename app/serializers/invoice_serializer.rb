class InvoiceSerializer
  include JSONAPI::Serializer
  attributes :status

  has_many :items
  belongs_to :merchant
  belongs_to :customer
  has_many :transactions
end
