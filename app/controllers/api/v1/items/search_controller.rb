class Api::V1::Items::SearchController < ApplicationController
  def index
    items = item_conditions
    if items == "too_many_params_error"
      render json: ErrorSerializer.new(ErrorMessage.new("Unable to process both name and price parameters", 400)).serialize_json, status: 400
    elsif items == "invalid_price_error"
      render json: ErrorSerializer.new(ErrorMessage.new("Prices may not be set below 0", 400)).serialize_json, status: 400
    elsif !items.empty?
      render json: ItemSerializer.new(items.first)
    else
      render json: {data: {}}
    end
  end

  private

    def item_conditions
      if params[:name] && params[:min_price] || params[:name] && params[:max_price]
        return "too_many_params_error"
      elsif params[:min_price].to_f < 0 || params[:max_price].to_f < 0
        return "invalid_price_error"
      elsif params[:name]
        return Item.searched_by_name(Item, params[:name])
      elsif params[:min_price] && params[:max_price]
        return Item.searched_by_both_prices(params[:min_price], params[:max_price])
      elsif params[:min_price]
        return Item.searched_by_min_price(params[:min_price])
      elsif params[:max_price]
        return Item.searched_by_max_price(params[:max_price])
      end
    end
end