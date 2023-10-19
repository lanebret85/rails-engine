require "rails_helper"

RSpec.describe Item do
  describe "relationships" do
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through (:invoice_items) }
    it { should belong_to :merchant }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :merchant_id }
  end

  describe "#searched_by_name" do
    it "can query an item by name and sort the results alphabetically by name" do
      martians = create(:item, name: "Spaceship for Martians")
      martini = create(:item, name: "Martini Glass")
      cool = create(:item, name: "Cool Thing")

      query = Item.searched_by_name(Item, "Mart")

      expect(query).to eq([martini, martians])
    end
  end

  describe "#searched_by_min_price" do
    it "can query an item with unit price greater than or equal to min_price and sort the results alphabetically by name" do
      airpods = create(:item, name: "airpods", unit_price: 200.00)
      ipad = create(:item, name: "ipad", unit_price: 650.00)
      iphone = create(:item, name: "iphone", unit_price: 999.00)

      query = Item.searched_by_min_price(250.00)

      expect(query).to eq([ipad, iphone])
    end
  end

  describe "#searched_by_max_price" do
    it "can query an item with unit price less than or equal to max_price and sort the results alphabetically by name" do
      airpods = create(:item, name: "airpods", unit_price: 200.00)
      ipad = create(:item, name: "ipad", unit_price: 650.00)
      iphone = create(:item, name: "iphone", unit_price: 999.00)

      query = Item.searched_by_max_price(750.00)

      expect(query).to eq([airpods, ipad])
    end
  end

  describe "#searched_by_both_prices" do
    it "can query an item with unit price greater than or equal to min_price and less than or equal to max_price and sort the results alphabetically by name" do
      airpods = create(:item, name: "airpods", unit_price: 200.00)
      ipad = create(:item, name: "ipad", unit_price: 650.00)
      iphone = create(:item, name: "iphone", unit_price: 999.00)

      query = Item.searched_by_both_prices(150.00, 1050.00)

      expect(query).to eq([airpods, ipad, iphone])
    end
  end
end