class Api::V1::Items::SearchController < ApplicationController
  def index
    if params[:name]
      render json: ItemSerializer.new(Item.searched_by_name(Item, params[:name]).first)
    elsif params[:min_price] && params[:max_price]
      render json: ItemSerializer.new(Item.searched_by_both_prices(params[:min_price], params[:max_price]).first)
    elsif params[:min_price]
      render json: ItemSerializer.new(Item.searched_by_min_price(params[:min_price]).first)
    elsif params[:max_price]
      render json: ItemSerializer.new(Item.searched_by_max_price(params[:max_price]).first)
    # elsif params[:name] && params[:min_price] || params[:name] && params[:max_price]

    # else
      
    end
  end
end