
require 'rails_helper'

RSpec.describe Api::GroupsController do

  describe 'GET index' do
    let(:user) { FactoryBot.create(:user) }
    let(:params) { { format: :json } }
    let(:group) { FactoryBot.create(:group) }
    let(:grade) { group.grade }

    context 'when user is signed in' do
      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :index, params: params

        response
      end

      context 'with groups' do
        before do
          group
        end

        context 'with teachers, principal and support teacher' do
          let(:principal) { FactoryBot.create(:user, :principal) }
          let(:teacher) { FactoryBot.create(:user) }
          let(:support_teacher) { FactoryBot.create(:user, :support_teacher) }

          before do
            UserGroup.create(group: group, user: principal, role_id: Role.find_by(name: :principal).id)
            UserGroup.create(group: group, user: teacher, role_id: Role.find_by(name: :teacher).id)
            UserGroup.create(group: group, user: support_teacher, role_id: Role.find_by(name: :support_teacher).id)
          end

          its(:status) { should eq(200) }

          its(:body) do
            should include_json(groups: [{
              id: group.id,
              name: group.name,
              grade: {
                id: grade.id,
                name: grade.name
              },
              principal: {
                ci: principal.ci.to_s,
                name: principal.name,
                surname: principal.surname,
                birthdate: principal.birthdate.to_s,
                address: principal.address,
                email: principal.email
              },
              support_teacher: {
                ci: support_teacher.ci.to_s,
                name: support_teacher.name,
                surname: support_teacher.surname,
                birthdate: support_teacher.birthdate.to_s,
                address: support_teacher.address,
                email: support_teacher.email
              },
              teachers: [{
                ci: teacher.ci.to_s,
                name: teacher.name,
                surname: teacher.surname,
                birthdate: teacher.birthdate.to_s,
                address: teacher.address,
                email: teacher.email
              }]
            }])
          end
        end
      end

      context 'without groups' do
        its(:status) { should eq(200) }

        its(:body) do
          should include_json(groups: [])
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

  describe 'POST create' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:grade) { FactoryBot.create(:grade) }
      let(:group_attrs) { FactoryBot.attributes_for(:group) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :create, params: params

        response
      end

      context 'with valid data' do
        context 'with valid grade id' do
          let(:params) { {grade_id: grade.id, group: group_attrs, format: :json} }

          its(:status) { should eq(201) }

          its(:body) do
            should include_json(grade: {
              group: {
                name: group_attrs[:name],
                year: group_attrs[:year],
                grade_name: grade.name
              }
            })
          end
        end
      end

      context 'with invalid data' do
        context 'with invalid data' do
          let(:invalid_group_attrs) { FactoryBot.attributes_for(:group, name: '') }

          let(:params) { {grade_id: grade.id, group: invalid_group_attrs, format: :json} }

          its(:status) { should eq(422) }

          its(:body) do
            should include_json(error: {
              key: 'record_invalid',
              description: {
                name: ['no puede estar en blanco']
              }
            })
          end
        end

        context 'with invalid grade id' do
          let(:params) { {grade_id: -1, group: group_attrs, format: :json} }

          its(:status) { should eq(404) }

          its(:body) do
            should include_json(error: {
              key: 'grade.not_found',
              description: I18n.t('grade.not_found')
            })
          end
        end
      end
    end

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:grade) { FactoryBot.create(:grade) }
      let(:group_attrs) { FactoryBot.attributes_for(:group) }
      let(:params) { {grade_id: grade.id, group: group_attrs, format: :json} }

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

  describe 'PATCH update' do
    let(:user) { FactoryBot.create(:user) }
    let(:group) { FactoryBot.create(:group) }
    let(:grade) { group.grade }

    context 'when user is signed in' do
      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        patch :update, params: params

        response
      end

      context 'with valid data' do
        let(:group_attrs) { FactoryBot.attributes_for(:group) }
        let(:params) { {grade_id: grade.id, id: group.id, group: group_attrs, format: :json} }

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(grade: {
            group: {
              name: group_attrs[:name],
              year: group_attrs[:year]
            }
          })
        end
      end

      context 'with invalid grade id' do
        let(:group_attrs) { FactoryBot.attributes_for(:group) }
        let(:params) { {grade_id: -1, id: group.id, group: group_attrs, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'grade.not_found',
            description: I18n.t('grade.not_found')
          })
        end
      end

      context 'with invalid group id' do
        let(:group_attrs) { FactoryBot.attributes_for(:group) }
        let(:params) { {grade_id: grade.id, id: -1, group: group_attrs, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'group.not_found',
            description: I18n.t('group.not_found')
          })
        end
      end

    end

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:group) { FactoryBot.create(:group) }
      let(:grade) { group.grade }
      let(:group_attrs) { FactoryBot.attributes_for(:group) }

      let(:params) { {grade_id: grade.id, id: group.id, group: group_attrs, format: :json} }

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
