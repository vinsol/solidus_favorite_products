# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::User, type: :model do
  let!(:user) do
    create(
      :user,
      email: 'test@example.com',
      password: 'spree123'
    )
  end
  let!(:shipping_category) do
    create(
      :shipping_category,
      name: 'shipping_category'
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
  let!(:favorite) do
    create(
      :favorite,
      user: user,
      product: product1
    )
  end

  it { is_expected.to respond_to(:favorites) }
  it { is_expected.to respond_to(:favorite_products) }

  describe 'has_favorite_product?' do
    context "when product in user's favorite products" do
      it { expect(user.has_favorite_product?(product1.id)).to be_truthy }
    end

    context 'when product is not in users favorite products' do
      it { expect(user.has_favorite_product?(product2.id)).to be_falsey }
    end
  end
end
