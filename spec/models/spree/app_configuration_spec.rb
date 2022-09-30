# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::AppConfiguration, type: :model do
  it { expect(Spree::Config.favorite_products_per_page).to eq(20) }
end
