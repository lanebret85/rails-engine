class ItemMerchantSerializer
  include JSONAPI::Serializer
  
  belongs_to :merchant
end