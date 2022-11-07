require 'rails_helper'

RSpec.describe Api::UserGroupsController do
  describe "POST user_group" do
    let(:user) { FactoryBot.create(:user) }
    let(:group) { FactoryBot.create(:group) }

    context 'when user is signed in' do
      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :create, params: params

        response
      end

      context 'when everything is right for the assosiation' do
        let(:params) { { user_group: { user_id: user.id, group_id: group.id } , role: "teacher", format: :json } }

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(user_group: {
            user: {
              email: user.email,
              password: nil,
              name: user.name,
              surname: user.surname,
              ci: user.ci,
              address: user.address,
              birthdate: user.birthdate.to_s,
              role: "teacher"
            },
            group: {
              name: group.name,
              year: group.year,
              grade: group.grade.name
            }
          })
        end
      end

      context 'when assosiation already exists' do
        let(:user2) { FactoryBot.create(:user, :with_group) }
        let(:params) { { user_group: { user_id: user2.id, group_id: user2.groups.first.id }, role: "teacher", format: :json } }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json(
            error: {
                key: "record_invalid",
                description: {
                    user_id: [
                        "ya está en uso"
                    ],
                    group_id: [
                        "ya está en uso"
                    ]
                }
            }
        )
        end
      end

      context 'when group does not exist' do
        let(:params) { { user_group: {  user_id: user.id, group_id: -1 }, role: "teacher", format: :json } }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(
            error: {
                key: "group.not_found",
                description: "Grupo no encontrado"
            }
        )
        end
      end

      context 'when user does not exist' do
        let(:params) { { user_group: {  user_id: -1, group_id: group.id } , role: "teacher", format: :json } }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(
            error: {
              key: "user.not_found",
              description: "Usuario no encontrado"
            }
        )
        end
      end
    end
  end

  describe "DELETE dismiss" do
    let(:user) { FactoryBot.create(:user, :with_group) }

    context 'when user is signed in' do
      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        delete :destroy, params: params

        response
      end

      context 'when everything is right for the disassosiation' do
        let(:params) { { user_group: {  user_id: user.id, group_id: user.groups.first.id } , role: "teacher", format: :json } }

        its(:status) { should eq(204) }
      end

      context 'when assosiation does not exist' do
        let(:user2) { FactoryBot.create(:user) }
        let(:params) { { user_group: { user_id: user2.id, group_id: user.groups.first.id } , role: "teacher", format: :json } }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(
            error: {
              key: "user_group.not_found",
              description: "Usuario no perteneciente al grupo"
            }
        )
        end
      end

      context 'when group does not exist' do
        let(:params) { { user_group: {  user_id: user.id, group_id: -1 } , role: "teacher", format: :json } }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(
            error: {
                key: "group.not_found",
                description: "Grupo no encontrado"
            }
        )
        end
      end

      context 'when user does not exist' do
        let(:params) { { user_group: {  user_id: -1, group_id: user.groups.first.id } , role: "teacher", format: :json } }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(
            error: {
              key: "user.not_found",
              description: "Usuario no encontrado"
            }
        )
        end
      end
    end
  end
end
