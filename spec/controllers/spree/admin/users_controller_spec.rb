# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Admin::UsersController, type: :controller do
  stub_authorization!

  let!(:user) { create(:user) }
  let!(:product) { create(:product, id: 10) }
  let!(:favorite) { create(:favorite, user: user, product: product) }
  let(:favorite_product) { user.favorite_products }
  let(:favorite_users) { double(ActiveRecord::Relation) }

  describe 'favorite_products' do
    def send_request
      get :favorite_products,
          params: {
            id: user.id
          }
    end

    before do
      allow(Spree::User).to receive(:find).and_return(user)
    end

    it 'is expected to set favorite_products' do
      send_request

      expect(response).to have_http_status(:ok)
    end
  end
end
