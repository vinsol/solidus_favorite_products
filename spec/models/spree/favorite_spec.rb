# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Favorite, type: :model do
  let!(:shipping_category) do
    create(
      :shipping_category,
      name: 'shipping_category'
    )
  end
  let!(:favorite_product1) do
    create(
      :product,
      name: 'favorite_product1',
      price: 100,
      shipping_category_id: shipping_category.id
    )
  end
  let!(:favorite_product2) do
    create(
      :product,
      name: 'favorite_product2',
      price: 100,
      shipping_category_id: shipping_category.id
    )
  end
  let!(:product1) do
    create(
      :product,
      name: 'product1',
      price: 100,
      shipping_category_id: shipping_category.id
    )
  end
  let!(:product2) do
    create(
      :product,
      name: 'product2',
      price: 100,
      shipping_category_id: shipping_category.id
    )
  end
  let!(:user1) do
    create(
      :user,
      email: 'user1@example.com',
      password: 'example',
      password_confirmation: 'example'
    )
  end
  let!(:user2) do
    create(
      :user,
      email: 'user2@example.com',
      password: 'example',
      password_confirmation: 'example'
    )
  end

  it { is_expected.to respond_to(:product) }
  it { is_expected.to respond_to(:user) }

  describe '.with_product_id' do
    let!(:favorite1) { user1.favorites.create!(product: favorite_product1) }
    let!(:favorite2) { user2.favorites.create!(product: favorite_product1) }
    let!(:favorite3) { user2.favorites.create!(product: favorite_product2) }

    it 'expects to list favorites with given product id' do
      expect(described_class.with_product_id(favorite_product1.id))
        .to include(favorite1, favorite2)
    end

    it 'expects not to list favorites with other product id' do
      expect(described_class.with_product_id(favorite_product1.id))
        .not_to include(favorite3)
    end
  end
end
