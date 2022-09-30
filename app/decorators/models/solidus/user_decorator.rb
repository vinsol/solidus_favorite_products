# frozen_string_literal: true

module Solidus
  module UserDecorator
    def self.prepended(base)
      base.class_eval do
        has_many :favorites,
                 dependent: :destroy
        has_many :favorite_products,
                 through: :favorites,
                 class_name: 'Spree::Product',
                 source: :product

        def has_favorite_product?(product_id)
          favorites.exists? product_id: product_id
        end
      end
    end

    ::Spree.user_class.prepend(self)
  end
end
