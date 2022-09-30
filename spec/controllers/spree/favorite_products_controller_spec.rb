# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::FavoriteProductsController do
  let!(:user) { create(:user) }
  let!(:product) { create(:product) }
  let!(:favorite1) { create(:favorite, user: user) }
  let!(:favorite2) { create(:favorite, user: user) }
  let(:favorites) { user.favorites }
  let(:proxy_object) { Object.new }

  shared_examples_for 'request which requires user authentication' do
    it 'authenticates user' do
      expect(controller).to receive(:authenticate_spree_user!)

      send_request
    end
  end

  shared_examples_for 'request which finds favorite product' do
    it 'finds favorite product' do
      expect(favorites).to receive(:with_product_id).with('id')

      send_request
    end

    it 'assigns favorite' do
      send_request

      expect(assigns(:favorite)).to eq(favorite1)
    end
  end

  describe 'POST create' do
    def send_request
      post :create,
           params: {
             id: 1
           },
           as: :js
    end

    before do
      allow(controller).to receive(:authenticate_spree_user!).and_return(true)
      allow(Spree::Favorite).to receive(:new).and_return(favorite1)
      allow(controller).to receive(:spree_current_user).and_return(user)
    end

    it_behaves_like 'request which requires user authentication'

    it 'creates favorite' do
      send_request

      expect(response).to have_http_status(:ok)
    end

    it 'saves favorite' do
      expect(favorite1).to receive(:save)

      send_request
    end

    context 'when favorite saved successfully' do
      it 'renders create' do
        send_request

        expect(response).to render_template(:create)
      end

      it 'should assign success message' do
        send_request

        expect(assigns(:message))
          .to eq('Product has been successfully marked as favorite')
      end
    end

    context 'when favorite not saved sucessfully' do
      before do
        allow(favorite1).to receive(:save).and_return(false)
        allow(favorite1).to receive(:errors).and_return(proxy_object)
        allow(proxy_object)
          .to receive(:full_messages).and_return(['Product already marked as favorite'])
      end

      it 'renders create template' do
        send_request

        expect(response).to render_template(:create)
      end

      it 'should assign error message' do
        send_request

        expect(assigns(:message)).to eq('Product already marked as favorite')
      end
    end
  end

  describe 'GET index' do
    def send_request
      get :index,
          params: {
            page: 'current_page'
          }
    end

    before do
      allow(Spree::Config)
        .to receive(:favorite_products_per_page).and_return('favorite_products_per_page')
      allow(controller).to receive(:authenticate_spree_user!).and_return(true)
      allow(controller).to receive(:spree_current_user).and_return(user)
    end

    it 'authenticates user' do
      expect(controller).to receive(:authenticate_spree_user!)

      send_request
    end

    it 'finds favorite products of current user' do
      send_request

      expect(response).to have_http_status(:ok)
      expect(user.favorite_products).not_to be_empty
    end

    it 'assigns favorite_products' do
      send_request

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'destroy' do
    def send_request(params = {})
      post :destroy,
           params: params.merge(
             {
               method: :delete,
               id: 'id'
             }
           ),
           as: :js
    end

    before do
      allow(favorites).to receive(:with_product_id).and_return([favorite1, favorite2])
      allow(controller).to receive(:authenticate_spree_user!).and_return(true)
      allow(controller).to receive(:spree_current_user).and_return(user)
    end

    it_behaves_like 'request which requires user authentication'
    it_behaves_like 'request which finds favorite product'

    context 'when favorite exist' do
      it 'destroys' do
        expect(favorite1).to receive(:destroy)

        send_request
      end

      context 'when destroyed successfully' do
        before do
          allow(favorite1).to receive(:destroy).and_return(true)
        end

        it 'sets @success to true' do
          send_request

          expect(assigns(:success)).to be(true)
        end
      end

      context 'when not destroyed' do
        before do
          allow(favorite1).to receive(:destroy).and_return(false)
        end

        it 'sets @success to false' do
          send_request

          expect(assigns(:success)).to be(false)
        end
      end
    end
  end
end
