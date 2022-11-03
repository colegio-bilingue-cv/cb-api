require 'rails_helper'

RSpec.describe Api::TeachersController do

  describe 'GET index' do
    let(:user) { FactoryBot.create(:user, :with_group) }

    context 'when user is signed in' do

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :index, params: params

        response
      end

      context 'with teachers' do
        let(:params) { { format: :json } }
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
        let(:params) { { format: :json } }

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(teachers: [])
        end
      end

      context 'with teachers in specific group' do
        let(:params) { { group_id: user.groups.first.id, format: :json } }
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

      context 'without teachers in specific group' do
        let(:group) { FactoryBot.create(:group) }
        let(:params) { { group_id: group.id, format: :json } }

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(teachers: [])
        end
      end

    end

    context 'when user is not signed in' do
      let(:params) { { format: :json } }

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

  describe "POST assign" do
    let(:user) { FactoryBot.create(:user) }
    let(:group) { FactoryBot.create(:group) }

    context 'when user is signed in' do
      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :assign, params: params

        response
      end

      context 'when everything is right for the assosiation' do
        let(:params) { { teacher: { user_id: user.id } , group_id: group.id, format: :json } }

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
        let(:params) { { teacher: { user_id: user2.id } , group_id: user2.groups.first.id, format: :json } }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json(
            error: {
                key: "record_invalid",
                description: {
                    user: [
                        "ya está en uso"
                    ],
                    group: [
                        "ya está en uso"
                    ]
                }
            }
        )
        end
      end

      context 'when group does not exist' do
        let(:params) { { teacher: { user_id: user.id } , group_id: -1, format: :json } }

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
        let(:params) { { teacher: { user_id: -1 } , group_id: group.id, format: :json } }

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
=begin
    context 'when user is not signed in' do
      let(:params) { { format: :json } }

      subject do
        post :assign, params: params

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
=end
  end

end
