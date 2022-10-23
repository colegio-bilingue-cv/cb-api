require 'rails_helper'

RSpec.describe Api::MeController do
  describe 'GET show' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      let(:params) { { id: user.id, format: :json } }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :show, params: params

        response
      end

      context 'with valid data' do

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(me: {
            ci: user.ci.to_s,
            name: user.name,
            surname: user.surname,
            birthdate: user.birthdate.to_s,
            address: user.address,
            email: user.email
          })
        end
      end
    end
    
    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:params) { { id: user.id, format: :json } }

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
