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
      let(:params) { {user: user_attrs, format: :json} }

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

  describe 'GET index' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :index, params: { format: :json }

        response
      end

      context 'with user' do

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(users: [{
            ci: user.ci.to_s,
            name: user.name,
            surname: user.surname,
            birthdate: user.birthdate.to_s,
            address: user.address,
            email: user.email
          }])
        end
      end
    end

    context 'when user is not signed in' do
      let(:params) { {user: user_attrs, format: :json} }

      subject do
        get :index, params: { format: :json }

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
    let(:user) { FactoryBot.create(:user) }

    context 'when user is signed in' do
      let(:user_2) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user_2)}"
        patch :update, params: params

        response
      end

      context 'with valid data' do
        let(:params) { {id: user.id, user: {address: 'New address 1234'}, format: :json} }

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
        let(:params) { {id: user.id, user: {ci: '111'}, format: :json} }

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

      context 'with invalid user id' do
        let(:params) { {id: -1, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'user.not_found',
            description: I18n.t('user.not_found')
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

end
