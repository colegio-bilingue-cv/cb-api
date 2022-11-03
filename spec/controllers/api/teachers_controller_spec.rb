require 'rails_helper'

RSpec.describe Api::TeachersController do

  describe 'GET index' do
    let(:user) { FactoryBot.create(:user, :with_group) }
    let(:params) { { format: :json } }

    context 'when user is signed in' do

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :index, params: params
        
        response
      end

      context 'with teachers' do        
        its(:status) { should eq(200) }

        its(:body) do
          should include_json(teachers: [
            {
              "name": user.name,
              "surname": user.surname,
              "groups": [
                {
                  "name": user.groups.first.name,
                  "year": user.groups.first.year,
                  "grade": user.groups.first.grade.name
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
