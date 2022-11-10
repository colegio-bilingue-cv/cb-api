require 'rails_helper'

RSpec.describe Api::UserGroupsController do
  describe 'POST user_group' do
    let(:user) { FactoryBot.create(:user) }
    let(:group) { FactoryBot.create(:group) }

    context 'when user is signed in' do
      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :create, params: params

        response
      end

      context 'with valid data' do
        let(:params) { { user_group: { user_id: user.id, group_id: group.id, role: :teacher }, format: :json } }

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(user_group: {
            user: {
              id: user.id,
              email: user.email,
              name: user.name,
              surname: user.surname,
              ci: user.ci,
              address: user.address,
              birthdate: user.birthdate.to_s,
              role: 'teacher'
            },
            group: {
              id: group.id,
              name: group.name,
              year: group.year,
              grade_name: group.grade_name
            }
          })
        end
      end

      context 'when association already exists' do
        let(:user_with_group) { FactoryBot.create(:user, :with_group) }
        let(:group) { user_with_group.groups.first }

        let(:params) { { user_group: { user_id: user_with_group.id, group_id: group.id, role: :teacher }, format: :json } }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json(
            error: {
              key: 'record_invalid',
              description: {
                user_id: ['ya está en uso'],
                group_id: ['ya está en uso']
              }
            }
          )
        end
      end

      context 'when group does not exist' do
        let(:params) { { user_group: {  user_id: user.id, group_id: -1, role: :teacher }, format: :json } }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(
            error: {
              key: 'group.not_found',
              description: 'Grupo no encontrado'
            }
          )
        end
      end

      context 'when user does not exist' do
        let(:params) { { user_group: { user_id: -1, group_id: group.id, role: :teacher }, format: :json } }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(
            error: {
              key: 'user.not_found',
              description: 'Usuario no encontrado'
            }
          )
        end
      end
    end
  end

  describe 'DELETE destroy' do
    let(:user) { FactoryBot.create(:user, :with_group) }
    let!(:group) { user.groups.first }

    context 'when user is signed in' do
      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        delete :destroy, params: params

        response
      end

      context 'with valid data' do
        let(:params) { { user_group: { user_id: user.id, group_id: group.id, role: :teacher}, format: :json } }

        its(:status) { should eq(204) }

        it 'destroys the user_group' do
          expect {
            subject
          }.to change(UserGroup, :count).by(-1)
        end

        it 'destroys the user association with the group' do
          expect {
            subject
          }.to change { user.groups.count }.by(-1)
        end
      end

      context 'when association does not exist' do
        let(:user_without_group) { FactoryBot.create(:user) }
        let(:params) { { user_group: { user_id: user_without_group.id, group_id: group.id, role: :teacher }, format: :json } }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(
            error: {
              key: 'user_group.not_found',
              description: 'Usuario no perteneciente al grupo'
            }
          )
        end
      end

      context 'when group does not exist' do
        let(:params) { { user_group: { user_id: user.id, group_id: -1, role: :teacher }, format: :json } }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(
            error: {
              key: 'group.not_found',
              description: 'Grupo no encontrado'
            }
          )
        end
      end

      context 'when user does not exist' do
        let(:params) { { user_group: { user_id: -1, group_id: user.groups.first.id, role: :teacher }, format: :json } }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(
            error: {
              key: 'user.not_found',
              description: 'Usuario no encontrado'
            }
          )
        end
      end
    end
  end
end
