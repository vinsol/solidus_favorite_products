# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Admin::ProductsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:product) { create(:product, id: 10) }
  let!(:favorite) { create(:favorite, user: user, product: product) }
  let(:favorite_product) { user.favorite_products }
  let(:favorite_users) { double(ActiveRecord::Relation) }

  stub_authorization!

  describe 'GET users' do
    def send_request
      get :favorite_users,
          params: {
            id: product.id
          }
    end

    before do
      allow(Spree::Product)
        .to receive_message_chain(:with_deleted, :friendly, :find) { product }
      allow(product).to receive(:favorite_users) { favorite_users }
    end

    it 'is expected to set favorite_users' do
      send_request

      expect(response).to have_http_status(:ok)
    end
  end
end
