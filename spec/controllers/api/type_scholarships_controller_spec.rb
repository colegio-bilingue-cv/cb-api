require 'rails_helper'

RSpec.describe Api::TypeScholarshipsController do
  describe 'GET index' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :index, params: { format: :json }

        response
      end

      context 'with type_scholarships' do
        let(:type_scholarship) { FactoryBot.create(:type_scholarship) }

        before do
          type_scholarship
        end

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(type_scholarships: [{
            scholarship: type_scholarship.scholarship.to_s,
            description: type_scholarship.description.to_s
          }])
        end
      end

      context 'without type_scholarships' do
        its(:status) { should eq(200) }

        its(:body) do
          should include_json(type_scholarships: [])
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
