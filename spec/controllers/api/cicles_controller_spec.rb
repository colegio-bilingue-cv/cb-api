require 'rails_helper'

RSpec.describe Api::CicleController do
  describe 'GET index' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :index, params: { format: :json }

        response
      end

      context 'with cicles' do
        let(:cicle) { FactoryBot.create(:cicle) }

        before do
          cicle
        end

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(cicles: [{
            id: cicle.id.to_s,
            name: cicle.name.to_s
          }])
        end
      end

      context 'without type_scholarships' do
        its(:status) { should eq(200) }

        its(:body) do
          should include_json(cicles: [])
        end
      end
    end

    context 'when user is not signed in' do
      let(:params) { {user: user_attrs, format: :json} }

      subject do
        get :index, params: { format: :json }

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json({})
      end
    end
  end
end
