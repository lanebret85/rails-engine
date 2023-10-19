class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :merchant_id, presence: true

  def self.searched_by_min_price(params)
    Item.where("unit_price >= ?", "#{params}")
    .order(:name)
  end

  def self.searched_by_max_price(params)
    Item.where("unit_price <= ?", "#{params}")
    .order(:name)
  end

  def self.searched_by_both_prices(min_params, max_params)
    Item.where("unit_price >= #{min_params} AND unit_price <= #{max_params}")
    .order(:name)
  end
end