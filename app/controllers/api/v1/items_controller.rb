module Api
  module V1
    class ItemsController < ApplicationController
      rescue_from ActiveRecord::RecordInvalid, with: :not_found_response

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
        item = Item.update!(params[:id], item_params)
        render json: ItemSerializer.new(item)
      end

      def destroy
        render json: Item.delete(params[:id])
      end

      private

        def not_found_response(error)
          render json: ErrorSerializer.new(ErrorMessage.new(error.message, 404)).serialize_json, status: 404
        end

        def item_params
          params.permit(:name, :description, :unit_price, :merchant_id)
        end
    end
  end
end