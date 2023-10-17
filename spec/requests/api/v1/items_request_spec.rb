require "rails_helper"

describe "Items API" do
  it "sends a list of all items" do
    create_list(:item, 10)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body,symbolize_names: true)[:data]

    expect(items.count).to eq(10)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to eq("item")

      expect(item).to have_key(:attributes)

      item_attributes = item[:attributes]

      expect(item_attributes).to have_key(:description)
      expect(item_attributes[:description]).to be_a(String)

      expect(item_attributes).to have_key(:unit_price)
      expect(item_attributes[:unit_price]).to be_a(Float)

      expect(item).to have_key(:relationships)

      item_relationships = item[:relationships]

      expect(item_relationships).to have_key(:merchant)
      expect(item_relationships[:merchant]).to have_key(:data)

      item_merchant = item_relationships[:merchant][:data]

      expect(item_merchant).to have_key(:id)
      expect(item_merchant[:id]).to be_a(String)
      expect(item_merchant).to have_key(:type)
      expect(item_merchant[:type]).to eq("merchant")

      expect(item_relationships).to have_key(:invoices)
      
      item_invoices = item_relationships[:invoices][:data]

      expect(item_invoices).to be_an(Array)
    end
  end
end