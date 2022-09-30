# frozen_string_literal: true

module Solidus
  module ProductDecorator
    def self.prepended(base)
      base.class_eval do
        has_many :favorites,
                 dependent: :destroy
        has_many :favorite_users,
                 through: :favorites,
                 class_name: 'Spree::User',
                 source: :user

        scope :favorite, -> { joins(:favorites).distinct }

        scope :order_by_favorite_users_count, ->(asc = false) do
          order(favorite_users_count: asc ? 'asc' : 'desc')
        end
      end
    end

    ::Spree::Product.prepend(self)
  end
end
