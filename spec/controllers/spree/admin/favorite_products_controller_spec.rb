# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Admin::FavoriteProductsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:role) { create(:role, name: 'user') }
  let(:roles) { [role] }
  let!(:product) { create(:product) }
  let(:proxy_object) { Object.new }
  let!(:favorite1) { create(:favorite, user: user) }
  let!(:favorite2) { create(:favorite, user: user) }
  let(:favorite_products) { user.favorite_products }
  let(:search) { double('search', result: favorite_products) }

  before do
    allow(user).to receive(:roles).and_return(proxy_object)
    allow(proxy_object).to receive(:includes).and_return([])
    allow(user).to receive(:has_spree_role?).with('admin').and_return(true)
    allow(controller).to receive(:spree_user_signed_in?).and_return(true)
    allow(controller).to receive(:spree_current_user).and_return(user)
    allow(user).to receive(:roles).and_return(roles)
    allow(roles).to receive(:includes).with(:permissions).and_return(roles)
    allow(controller).to receive(:authorize_admin).and_return(true)
    allow(controller).to receive(:authorize!).and_return(true)
    allow(favorite_products).to receive(:includes).and_return(favorite_products)
    allow(favorite_products)
      .to receive(:order_by_favorite_users_count).and_return(favorite_products)
    allow(favorite_products).to receive(:search).and_return(search)
    allow(favorite_products).to receive(:page).and_return(favorite_products)
    allow(Spree::Product).to receive(:favorite).and_return(favorite_products)
  end

  describe 'GET index' do
    def send_request
      get :index,
          params: {
            page: 1,
            q: {
              s: 'name desc'
            }
          }
    end

    it 'returns favorite products' do
      expect(Spree::Product).to receive(:favorite)

      send_request
    end

    it 'searches favorite products' do
      search_params = ActionController::Parameters.new(s: 'name desc')
      expect(favorite_products).to receive(:search).with(search_params)

      send_request
    end

    it 'assigns search' do
      send_request

      expect(assigns(:search)).to eq(search)
    end

    context 'when order favorite products by users count in asc order' do
      def send_request
        get :index,
          params: {
            page: 1,
            q: {
              s: 'favorite_users_count asc'
            }
          }
      end

      it 'orders favorite products by users count in asc order' do
        expect(favorite_products)
          .to receive(:order_by_favorite_users_count).with(true)

        send_request
      end
    end

    context 'when order favorite products by users count in desc order' do
      it 'orders favorite products by users count in asc order' do
        expect(favorite_products)
          .to receive(:order_by_favorite_users_count).with(false)

        send_request
      end
    end

    it 'paginates favorite products' do
      expect(favorite_products).to receive(:page).with('1')

      send_request
    end

    it 'renders favorite products template' do
      send_request

      expect(response).to render_template(:index)
    end
  end
end
