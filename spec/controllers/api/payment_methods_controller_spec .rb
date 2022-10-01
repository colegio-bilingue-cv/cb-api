require 'rails_helper'

RSpec.describe Api::PaymentMethodController do
  describe 'GET index' do
    subject do
      get :index, params: { format: :json }

      response
    end

    context 'with payment_method' do
      let(:payment_method) { FactoryBot.create(:payment_method) }

      before do
        payment_method
      end

      its(:status) { should eq(200) }

      its(:body) do
        should include_json(payment_methods: [{
          method: payment_method.method
        })
      end
    end

    context 'with invalid data' do
      let(:invalid_payment_method) { FactoryBot.build(:payment_method, :with_invalid_data) }
      let(:payment_method_attrs) { invalid_payment_method.attributes }

      let(:invalid_params) { {student: paymnet_method_attrs, format: :json} }

      subject do
        post :create, params: invalid_params

        response
      end

      its(:status) { should eq(422) }

      its(:body) do
        should include_json({})
      end
    end

  end

  describe 'GET show' do
    let(:payment_method) { FactoryBot.create(:payment_method) }

    let(:params) do
      { id: payment_method.id, format: :json }
    end

    subject do
      get :show, params: params

      response
    end

    context 'with valid id' do
      its(:status) { should eq(200) }

      its(:body) do
        should include_json(student: {
          id: payment_method.id,
          method: payment_method.method
        })
      end
    end

    context 'with invalid id' do
      let(:params) do
        { id: -1, format: :json }
      end

      its(:status) { should eq(404) }

      its(:body) do
        should include_json({})
      end
    end

  end
end
