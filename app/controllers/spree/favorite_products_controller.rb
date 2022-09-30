# frozen_string_literal: true

module Spree
  class FavoriteProductsController < Spree::StoreController
    prepend_before_action :store_favorite_product_preference, only: :create
    before_action :authenticate_spree_user!
    before_action :find_favorite_product, only: :destroy

    def index
      @favorite_products = spree_current_user.favorite_products
                                             .page(params[:page])
                                             .per(Spree::Config.favorite_products_per_page)
    end

    def create
      @favorite = spree_current_user.favorites.new(product_id: params[:id])
      @message = if @favorite.save
                   @sucess = true
                   I18n.t('spree.favorite_products.create.success')
                 else
                   @sucess = false
                   @favorite.errors.full_messages.to_sentence
                 end

      respond_to do |format|
        format.js
      end
    end

    def destroy
      return unless @favorite

      @success = @favorite.destroy
    end

    private

    def find_favorite_product
      @favorite = spree_current_user.favorites.with_product_id(params[:id]).first
    end

    def store_favorite_product_preference
      return if spree_current_user

      session[:spree_user_return_to] = product_path(
        id: params[:id],
        favorite_product_id: params[:id]
      )
      redirect_to login_path, notice: I18n.t('spree.login_to_add_favorite')
    end
  end
end
