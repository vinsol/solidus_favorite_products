# frozen_string_literal: true

module Spree
  module Admin
    class FavoriteProductsController < Spree::Admin::BaseController
      def index
        @search = Spree::Product.favorite.includes(master: :images).search(params[:q])
        @favorite_products = @search.result.order_by_favorite_users_count(sort_in_ascending_users_count?).page(params[:page])
      end

      private

      def sort_in_ascending_users_count?
        params[:q] && params[:q][:s] == 'favorite_users_count asc'
      end

      def model_class
        Spree::Product
      end
    end
  end
end
