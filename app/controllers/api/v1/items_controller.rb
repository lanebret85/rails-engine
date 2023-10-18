module Api
  module V1
    class ItemsController < ApplicationController
      def index
        render json: ItemSerializer.new(Item.all)
      end

      def show
        render json: ItemSerializer.new(Item.find(params[:id]))
      end

      def create
        render json: ItemSerializer.new(Item.create!(item_params)), status: 201
      end

      def update
        # item = Item.find(params[:id])
        # render json: ItemSerializer.new(item.update!(item_params))
        render json: ItemSerializer.new(Item.update!(item_params))
      end

      def destroy
        render json: Item.delete(params[:id])
      end

      private

        def item_params
          params.permit(:name, :description, :unit_price, :merchant_id)
        end
    end
  end
end