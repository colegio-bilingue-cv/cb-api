
require 'rails_helper'

RSpec.describe Api::CiclesController do

  describe 'GET index' do
    let(:user) { FactoryBot.create(:user) }
    let(:params) { { format: :json } }

    context 'when user is signed in' do
      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :index, params: params

        response
      end

      context 'with cicles' do
        let(:cicle) { FactoryBot.create(:cicle) }

        before do
          cicle
        end

        context 'with questions' do
          let(:question) { FactoryBot.create(:question) }

          before do
            cicle.questions << question
          end

          its(:status) { should eq(200) }

          its(:body) do
            should include_json(cicles: [{
              name: cicle.name,
              questions: [{
                text: question.text
              }]
            }])
          end
        end

        context 'without questions' do
          its(:status) { should eq(200) }

          its(:body) do
            should include_json(cicles: [{
              name: cicle.name,
              questions: []
            }])
          end
        end
      end

      context 'without cicles' do
        its(:status) { should eq(200) }

        its(:body) do
          should include_json(cicles: [])
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
