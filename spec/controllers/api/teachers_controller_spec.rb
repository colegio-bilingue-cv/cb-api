require 'rails_helper'

RSpec.describe Api::TeachersController do

  describe 'GET index' do
    let(:user) { FactoryBot.create(:user) }
    let(:params) { { format: :json } }

    context 'when user is signed in' do

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :show, params: params
  
        response
      end

      context 'with teachers' do
        let(:teacher) { FactoryBot.create(:user) }
        let(:group) { FactoryBot.create(:group) }
        let(:user_group) { FactoryBot.create(:user_group, :teacher, user_id: teacher.id, group_id: group.id) }

        #before do
        #  teacher
        #end

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(teachers: [
            {
              "name": teacher.name,
              "surname": teacher.surname,
              "groups": [
                {
                  "name": group.name,
                  "year": group.year,
                  "grade": group.grade.name
                }
              ]
            }
          ])
        end        
      end

      context 'without teachers' do
        its(:status) { should eq(200) }

        its(:body) do
          should include_json(teachers: [])
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
