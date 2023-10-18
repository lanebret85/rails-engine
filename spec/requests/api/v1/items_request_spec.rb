require "rails_helper"

describe "Items API" do
  it "sends a list of all items" do
    create_list(:item, 10)

    get '/api/v1/items'

    expect(response).to be_successful

    items_hash = JSON.parse(response.body,symbolize_names: true)

    expect(items_hash).to be_a(Hash)
    
    items = items_hash[:data]

    expect(items.count).to eq(10)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to eq("item")

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)

      item_attributes = item[:attributes]

      expect(item_attributes).to have_key(:description)
      expect(item_attributes[:description]).to be_a(String)

      expect(item_attributes).to have_key(:unit_price)
      expect(item_attributes[:unit_price]).to be_a(Float)
      
      expect(item_attributes).to have_key(:merchant_id)
      expect(item_attributes[:merchant_id]).to be_an(Integer)
    end
  end

  it "sends a single item result" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    item_hash = JSON.parse(response.body,symbolize_names: true)

    expect(item_hash).to be_a(Hash)
    
    item = item_hash[:data]

    expect(item).to have_key(:id)
    expect(item[:id]).to be_a(String)

    expect(item).to have_key(:type)
    expect(item[:type]).to eq("item")

    expect(item).to have_key(:attributes)
    expect(item[:attributes]).to be_a(Hash)

    item_attributes = item[:attributes]

    expect(item_attributes).to have_key(:name)
    expect(item_attributes[:name]).to be_a(String)

    expect(item_attributes).to have_key(:description)
    expect(item_attributes[:description]).to be_a(String)

    expect(item_attributes).to have_key(:unit_price)
    expect(item_attributes[:unit_price]).to be_a(Float)

    expect(item_attributes).to have_key(:merchant_id)
    expect(item_attributes[:merchant_id]).to be_an(Integer)
  end

  it "can create a new item" do
    item = create(:item)

    item_params = {
                    name: item.name,
                    description: item.description,
                    unit_price: item.unit_price,
                    merchant_id: item.merchant_id
                  }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item_params)
    created_item = Item.last

    expect(response).to be_successful

    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can update an existing item" do
    id = create(:item).id
    previous_name = Item.last.name
    current_description = Item.last.description
    current_unit_price = Item.last.unit_price
    current_merchant_id = Item.last.merchant_id
    item_params = { name: "Item Priori Incantatum" }
    headers = { "CONTENT_TYPE" => "application/json" }

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item_params)

    item = Item.find(id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(current_description)
    expect(item.unit_price).to eq(current_unit_price)
    expect(item.merchant_id).to eq(current_merchant_id)
  end
end