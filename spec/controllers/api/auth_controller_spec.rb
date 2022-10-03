require 'rails_helper'

RSpec.describe Api::AuthController do
  let(:user) { FactoryBot.create(:user, password: 'password') }

  describe 'POST sign_in' do

    subject do
      post :sign_in, params: params

      response
    end

    context 'with valid data' do
      let(:params) { {email: user.email, password: 'password'} }

      its(:status) { should eq(200) }

      its(:body) do
        should include_json(user: {
          ci: user.ci,
          name: user.name,
          surname: user.surname,
          birthdate: user.birthdate.to_s,
          address: user.address,
          email: user.email
        })
      end

      it 'should include Authorization header' do
        expect(subject.headers['Authorization']).to be
      end

    end

    context 'with invalid password' do
      let(:params) { {email: user.email, password: 'invalid'} }

      its(:status) { should eq(401) }

      its(:body) { should include_json({}) }
    end

    context 'with invalid email' do
      let(:params) { {email: 'invalid', password: 'password'} }

      its(:status) { should eq(401) }

      its(:body) { should include_json({}) }
    end

  end

  describe 'POST sign_out' do
    context "with valid token" do
      let(:user) { FactoryBot.create(:user, password: 'password') }
      let(:auth_header) do
        post :sign_in, params: {email: user.email, password: 'password'}
        response.headers['Authorization']
      end

      subject do
        request.headers['Authorization'] = auth_header
        post :sign_out

        response
      end

      its(:status) { should eq(200) }

    end
  end

end
