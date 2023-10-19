class Api::V1::Merchants::SearchController < ApplicationController
  def index
    if params[:name]
      render json: MerchantSerializer.new(Merchant.searched_by_name(Merchant,params[:name]))
    end
  end
end