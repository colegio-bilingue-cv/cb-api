require 'rails_helper'

RSpec.describe Api::UsersController do
  describe 'POST create' do
    let(:user_attrs) { FactoryBot.attributes_for(:user, role: :teacher) }

    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"

        post :create, params: params
        response
      end

      context 'with valid data' do
        let(:params) { {user: user_attrs, format: :json} }

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(user: {
            ci: user_attrs[:ci].to_s,
            name: user_attrs[:name],
            surname: user_attrs[:surname],
            birthdate: user_attrs[:birthdate].to_s,
            address: user_attrs[:address],
            email: user_attrs[:email]
          })
        end
      end

      context 'with invalid data' do
        let(:user_attrs) { FactoryBot.attributes_for(:user, :with_invalid_data) }

        let(:params) { {user: user_attrs, format: :json} }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json({})
        end
      end
    end

    context 'when user is not signed in' do
      let(:params) { {user: user_attrs, format: :json} }

      subject do
        post :create, params: params

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json({})
      end
    end
  end
end
