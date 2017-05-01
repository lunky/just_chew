require 'rails_helper'

RSpec.describe Order::PreferencesController, type: :controller do

  let(:user)             { create :user }
  let(:order_preference) { user.order_preference }

  describe 'PUT #update' do

    let(:params) { %i(type) }

    let(:attrs) { attributes_for(:order_preference, type: 'pickup').slice(*params) }

    let(:assigned_order_preference) { assigns(:order_preference) }

    let(:assigned_attrs) do
      assigned_order_preference.reload.attributes.symbolize_keys.slice(*params)
    end

    context 'as guest' do

      before { put :update, params: { order_preference: attrs } }

      it { should respond_with :redirect }

      it { should redirect_to sign_in_path }
    end

    context 'as user' do

      before { sign_in_as user }

      context 'valid params' do

        let(:json) { serialize(order_preference).as_json }

        before { put :update, params: { order_preference: attrs } }

        it { should respond_with :success }

        it 'should update order preference' do
          expect(attrs).to eq assigned_attrs
        end

        it 'should be valid' do
          expect(assigned_order_preference).to be_valid
        end

        it 'should render json' do
          expect(response.json).to eq json
        end
      end

      context 'invalid params' do

        let(:json) { serialize order_preference.errors }

        let(:attrs) do
          attributes_for(:order_preference, type: nil).slice(*params)
        end

        before { put :update, params: { order_preference: attrs } }

        it { should respond_with :unprocessable_entity }

        it 'should not update order preference' do
          expect(attrs).to_not eq assigned_attrs
        end

        it 'should not be valid' do
          expect(assigned_order_preference).to_not be_valid
        end

        it 'should render json' do
          expect(response.json).to eq json
        end
      end
    end
  end

end