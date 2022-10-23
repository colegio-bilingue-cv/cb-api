
require 'rails_helper'

RSpec.describe Api::GradesController do

  describe 'GET index' do
    let(:user) { FactoryBot.create(:user) }
    let(:params) { { format: :json } }

    context 'when user is signed in' do
      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :index, params: params

        response
      end

      context 'with grades' do
        let(:grade) { FactoryBot.create(:grade) }

        before do
          grade
        end

        context 'with groups' do
          let(:group) { FactoryBot.create(:group, grade: grade) }

          its(:status) { should eq(200) }

          its(:body) do
            should include_json(grades: [{
              id: grade.id,
              name: grade.name,
              groups: [{
                id: group.id,
                name: group.name
              }]
            }])
          end
        end

        context 'without groups' do
          its(:status) { should eq(200) }

          its(:body) do
            should include_json(grades: [{
              id: grade.id,
              name: grade.name,
              groups: []
            }])
          end
        end
      end

      context 'without grades' do
        its(:status) { should eq(200) }

        its(:body) do
          should include_json(grades: [])
        end
      end
    end

    context 'when user is not signed in' do
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
