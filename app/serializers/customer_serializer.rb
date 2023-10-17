class CustomerSerializer
  include JSONAPI::Serializer
  attributes :first_name, :last_name

  has_many :invoices
end
