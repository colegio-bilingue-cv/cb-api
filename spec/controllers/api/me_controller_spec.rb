require 'rails_helper'

RSpec.describe Api::MeController do
  describe 'GET show' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      let(:params) { { id: user.id, format: :json } }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :show, params: params

        response
      end

      context 'with valid data' do

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(me: {
            ci: user.ci.to_s,
            name: user.name,
            surname: user.surname,
            birthdate: user.birthdate.to_s,
            address: user.address,
            email: user.email
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:params) { { id: user.id, format: :json } }

      subject do
        get :show, params: params

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
  describe 'PATCH update' do

    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        patch :update, params: params

        response
      end

      context 'with valid data' do
        let(:params) { {user: {address: 'New address 1234'}, format: :json} }

        it 'changes the address' do
          expect {
            subject

            user.reload
          }.to change(user, :address).to('New address 1234')
        end

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(user: {
            ci: user[:ci].to_s,
            name: user[:name],
            surname: user[:surname],
            birthdate: user[:birthdate].to_s,
            address: 'New address 1234',
            email: user[:email]
          })
        end
      end

      context 'with invalid data' do
        let(:params) { {user: {ci: '111'}, format: :json} }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json(error: {
            key: 'record_invalid',
            description: {
              ci: ['es demasiado corto (8 caracteres mínimo)']
            }
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:params) { { id: user.id, format: :json} }

      subject do
        patch :update, params: params

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

  describe 'PATCH update password' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        patch :password, params: params

        response
      end

      context 'with valid data' do
        let(:params) { {user: { password:'new_password1', password_confirmation:'new_password1' }, format: :json} }

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(user: {
            ci: user[:ci].to_s,
            name: user[:name],
            surname: user[:surname],
            birthdate: user[:birthdate].to_s,
            address: user[:address],
            email: user[:email]
          })
        end
      end

      context 'with invalid data' do
        let(:params) { {user: { password: '111', password_confirmation: '111' }, format: :json} }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json(error: {
            key: 'record_invalid',
            description: {
              password: ['es demasiado corto (6 caracteres mínimo)']
            }
          })
        end
      end

      context 'with invalid password_confirmation' do
        let(:params) { {user: { password:'new_password', password_confirmation:'diferent_password' }, format: :json} }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json(error: {
            key: 'record_invalid',
            description: {
              password_confirmation: ['no coincide']
            }
          })
        end
      end

    end

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:params) { { user: { password:'new_password', password_confirmation:'new_password' }, format: :json} }

      subject do
        patch :password, params: params

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
