require "rails_helper"

describe "Merchant API" do
  it "sends a list of all items" do
    create_list(:merchant, 10)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants_hash = JSON.parse(response.body,symbolize_names: true)

    expect(merchants_hash).to be_a(Hash)
    
    merchants = merchants_hash[:data]

    expect(merchants).to be_an(Array)
    expect(merchants.count).to eq(10)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to eq("merchant")

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_a(Hash)

      merchant_attributes = merchant[:attributes]

      expect(merchant_attributes).to have_key(:name)
      expect(merchant_attributes[:name]).to be_a(String)
    end
  end

  it "sends a single merchant result" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    merchant_hash = JSON.parse(response.body,symbolize_names: true)

    expect(merchant_hash).to be_a(Hash)
    
    merchant = merchant_hash[:data]

    expect(merchant).to be_a(Hash)

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_a(String)

    expect(merchant).to have_key(:type)
    expect(merchant[:type]).to eq("merchant")

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_a(Hash)

    merchant_attributes = merchant[:attributes]

    expect(merchant_attributes).to have_key(:name)
    expect(merchant_attributes[:name]).to be_a(String)
  end

  it "can send the info of the items associated with a merchant" do
    id = create(:merchant).id
    create_list(:item, 10, merchant_id: id)

    get "/api/v1/merchants/#{id}/items"

    expect(response).to be_successful
    
    items_hash = JSON.parse(response.body,symbolize_names: true)
    
    expect(items_hash).to be_a(Hash)
    
    items = items_hash[:data]

    expect(items).to be_an(Array)

    items.each do |item|
      expect(item).to be_a(Hash)
      
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)
      
      expect(item).to have_key(:type)
      expect(item[:type]).to eq("item")
      
      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)
      
      item_attributes = item[:attributes]
      
      expect(item_attributes).to be_a(Hash)
      
      expect(item_attributes).to have_key(:name)
      expect(item_attributes[:name]).to be_a(String)

      expect(item_attributes).to have_key(:description)
      expect(item_attributes[:description]).to be_a(String)

      expect(item_attributes).to have_key(:unit_price)
      expect(item_attributes[:unit_price]).to be_a(Float)

      expect(item_attributes).to have_key(:merchant_id)
      expect(item_attributes[:merchant_id]).to be_an(Integer)
      expect(item_attributes[:merchant_id]).to eq(id)
    end
  end
end
