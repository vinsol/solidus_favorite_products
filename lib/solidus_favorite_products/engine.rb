# frozen_string_literal: true

require 'solidus_favorite_products'

module SolidusFavoriteProducts
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace Spree

    engine_name 'solidus_favorite_products'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
