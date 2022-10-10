require 'rails_helper'

RSpec.describe Api::PaymentMethodsController do
  describe 'GET index' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :index, params: { format: :json }

        response
      end

      context 'with payment_method' do
        let(:payment_method) { FactoryBot.create(:payment_method, method: Faker::Music::Prince.album) }

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(payment_methods: [{
            method: payment_method.method
          }])
        end
      end

      context 'with no payment methods' do
        its(:status) { should eq(200) }

        its(:body) do
          should include_json(payment_methods: [])
        end
      end
    end

    context 'when user is not signed in' do
      subject do
        get :index, params: { format: :json }

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json(error: {
          key: 'forbidden.required_signed_in',
          description: I18n.t('errors.forbidden.required_signed_in')
        })
      end
    end

  end

  describe 'GET show' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:payment_method) { FactoryBot.create(:payment_method, method: Faker::Music::Prince.album) }

      let(:params) { { id: payment_method.id, format: :json } }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :show, params: params

        response
      end

      context 'with valid id' do
        its(:status) { should eq(200) }

        its(:body) do
          should include_json(payment_method: {
            id: payment_method.id,
            method: payment_method.method
          })
        end
      end

      context 'with invalid id' do
        let(:params) { { id: -1, format: :json } }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'payment_method.not_found',
            description: I18n.t('payment_method.not_found')
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:payment_method) { FactoryBot.create(:payment_method, method: Faker::Music::Prince.album) }

      let(:params) { { id: payment_method.id, format: :json } }
      subject do
        get :show, params: params

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json(error: {
          key: 'forbidden.required_signed_in',
          description: I18n.t('errors.forbidden.required_signed_in')
        })
      end
    end
  end
end
