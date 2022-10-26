require 'rails_helper'

RSpec.describe Api::FinalEvaluationController do

  describe 'POST create' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      let(:student) { FactoryBot.create(:student) }
      let(:group) { FactoryBot.create(:group) }

      let(:final_evaluation) { FactoryBot.create(:final_evaluation, :passed, student_id: student.id, group_id: group.id) }
      let(:final_evaluation_attrs) { final_evaluation.attributes }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :create, params: params

        response
      end

      context 'with valid data' do
        let(:params) { { student_id: student.id, final_evaluation: final_evaluation_attrs, format: :json} }

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(final_evaluation: {
            student_id: student.id,
            group_id: group.id,
            status: final_evaluation.status,
            group_name: group.name,
            year: group.year
          })
        end
      end

      context 'with invalid student id' do
        let(:params) { {student_id: student.id, final_evaluation: {student_id: -1, group_id: group.id, status: final_evaluation.status}, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end

      context 'with invalid group id' do
        let(:params) { {student_id: student.id, final_evaluation: {student_id: student.id, group_id: -1, status: final_evaluation.status}, format: :json} }

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
      let(:student) { FactoryBot.create(:student) }
      let(:group) { FactoryBot.create(:group) }

      let(:final_evaluation) { FactoryBot.create(:final_evaluation, :passed, student_id: student.id, group_id: group.id) }
      let(:final_evaluation_attrs) { final_evaluation.attributes }

      let(:params) { {student_id: student.id, final_evaluation: final_evaluation_attrs, format: :json} }

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

end
