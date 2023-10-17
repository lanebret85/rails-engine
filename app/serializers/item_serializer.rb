class ItemSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :unit_price

  has_many :invoices
  belongs_to :merchant
end
