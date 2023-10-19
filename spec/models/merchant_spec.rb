require "rails_helper"

RSpec.describe Merchant do
  describe "relationships" do
    it { should have_many :invoices }
    it { should have_many :items }
  end

  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "#searched_by_name" do
    it "can query a list of merchants by name and sort the results alphabetically by name" do
      apple_store = create(:merchant, name: "Apple Store")
      applebees = create(:merchant, name: "Applebees")
      vance_refrigeration = create(:merchant, name: "Vance Refrigeration and Appliances")
      market = create(:merchant, name: "Black Market Appendix Shop")
      michael_scott = create(:merchant, name: "Michael Scott Paper Company")

      query = Merchant.searched_by_name(Merchant, "app")

      expect(query).to eq([apple_store, applebees, market, vance_refrigeration])
    end
  end
end