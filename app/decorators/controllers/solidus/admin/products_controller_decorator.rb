# frozen_string_literal: true

module Solidus
  module Admin
    module ProductsControllerDecorator
      def self.prepended(base)
        base.class_eval do
          def favorite_users
            @users = @product.favorite_users
                             .page(params[:page])
                             .per(Spree::Config.favorite_users_per_page)
          end
        end
      end

      ::Spree::Admin::ProductsController.prepend(self)
    end
  end
end
