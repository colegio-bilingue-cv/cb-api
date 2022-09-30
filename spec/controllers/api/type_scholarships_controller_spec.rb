require 'rails_helper'

RSpec.describe Api::TypeScholarshipsController do
  describe 'GET index' do
    subject do
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
end
