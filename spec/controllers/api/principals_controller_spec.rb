require 'rails_helper'

RSpec.describe Api::PrincipalsController do

  describe 'GET index' do
    let(:user) { FactoryBot.create(:user, :principal ) }

  context 'when user is signed in' do

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :index, params: params

        response
      end

      context 'with principals' do
        let(:params) { { format: :json } }
        its(:status) { should eq(200) }

        its(:body) do
          should include_json(principals: [{
            ci: user.ci,
            name: user.name,
            surname: user.surname,
          }])
        end
      end

      context 'without principals' do
        let(:params) { { format: :json } }

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(principals: [])
        end
      end
    end

    context 'when user is not signed in' do
      let(:params) { { format: :json } }
      subject do
        get :index, params: params

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