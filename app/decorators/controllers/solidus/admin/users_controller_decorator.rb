# frozen_string_literal: true

module Solidus
  module Admin
    module UsersControllerDecorator
      def self.prepended(base)
        base.class_eval do
          def favorite_products
            @favorite_products = @user.favorite_products
                                      .page(params[:page])
                                      .per(Spree::Config.favorite_products_per_page)
          end
        end
      end

      ::Spree::Admin::UsersController.prepend(self)
    end
  end
end
