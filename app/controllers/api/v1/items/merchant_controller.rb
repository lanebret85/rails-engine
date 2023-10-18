class Api::V1::Items::MerchantController < ApplicationController
  def index
    render json: ItemMerchantSerializer.new((Item.find(params[:item_id]).merchant))
  end
end