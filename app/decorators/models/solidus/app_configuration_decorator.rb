# frozen_string_literal: true

module Solidus
  module AppConfigurationDecorator
    def self.prepended(base)
      base.class_eval do
        preference :favorite_products_per_page, :integer, default: 20
        preference :favorite_users_per_page, :integer, default: 20
      end
    end

    ::Spree::AppConfiguration.prepend(self)
  end
end
