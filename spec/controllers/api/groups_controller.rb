
require 'rails_helper'

RSpec.describe Api::GroupsController do

  describe 'GET index' do
    let(:user) { FactoryBot.create(:user) }
    let(:params) { { format: :json } }
    let(:group) { FactoryBot.create(:group) }

    context 'when user is signed in' do
      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :index, params: params

        response
      end

      context 'with groups' do
        before do
          group
        end

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(groups: [{
            id: group.id,
            name: group.name
          }])
        end

        context 'without groups' do
          its(:status) { should eq(200) }

          its(:body) do
            should include_json(groups: [])
          end
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

  describe 'POST create' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:grade) { FactoryBot.create(:grade) }
      let(:group_attrs) { FactoryBot.attributes_for(:group) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :create, params: params

        response
      end

      context 'with valid grade id' do
        let(:params) { {grade_id: grade.id, group: group_attrs, format: :json} }

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(grade: {
            group: {
              name: group_attrs[:name],
              year: group_attrs[:year]
            }
          })
        end
      end

      context 'with invalid grade id' do
        let(:params) { {grade_id: -1, group: group_attrs, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'grade.not_found',
            description: I18n.t('grade.not_found')
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:grade) { FactoryBot.create(:grade) }
      let(:group_attrs) { FactoryBot.attributes_for(:group) }
      let(:params) { {grade_id: grade.id, group: group_attrs, format: :json} }

      subject do
        post :create, params: params

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
