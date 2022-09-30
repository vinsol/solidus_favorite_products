# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Product, type: :model do
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

  before do
    user1.favorites.create!(product: favorite_product1)
    user2.favorites.create!(product: favorite_product1)
    user2.favorites.create!(product: favorite_product2)
  end

  it { is_expected.to respond_to(:favorites) }
  it { is_expected.to respond_to(:favorite_users) }

  describe 'Spree::Product.favorite' do
    it 'returns favorite products' do
      expect(described_class.favorite)
        .to match_array([favorite_product1, favorite_product2])
    end
  end

  describe '.order_by_favorite_users_count' do
    context 'when order not passed' do
      it 'returns products ordered by users_count in descending order' do
        expect(described_class.favorite.order_by_favorite_users_count)
          .to eq([favorite_product1, favorite_product2])
      end
    end

    context 'when asc order passed' do
      it 'returns products ordered by users_count in ascending order' do
        expect(described_class.favorite.order_by_favorite_users_count(true))
          .to eq([favorite_product2, favorite_product1])
      end
    end
  end
end
