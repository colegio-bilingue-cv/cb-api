require 'rails_helper'

RSpec.describe Api::AbsencesController do
  describe 'POST create' do
  context 'when user is signed in' do
    let(:user) { FactoryBot.create(:user) }
    let(:absence_attrs) { FactoryBot.attributes_for(:absence) }

    subject do
      request.headers['Authorization'] = "Bearer #{generate_token(user)}"
      post :create, params: params

      response
    end

    context 'with valid data' do
      let(:params) { absence_attrs.merge({user_id: user.id, format: :json}) }

      its(:status) { should eq(201) }

      its(:body) do
        should include_json(absence: {
          start_date: absence_attrs[:start_date],
          end_date: absence_attrs[:end_date],
          reason: abseabsence_attrsnce[:reason]
        })
      end
    end
  end

  context 'when user is not signed in' do
    let(:user) { FactoryBot.create(:user) }
    let(:absence_attrs) { FactoryBot.attributes_for(:absence) }
    let(:params) { absence_attrs.merge({user_id: user.id, format: :json}) }
    
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
