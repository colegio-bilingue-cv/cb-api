require 'rails_helper'

RSpec.describe Api::FinalEvaluationController do

  describe 'POST create' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      let(:student) { FactoryBot.create(:student) }
      let(:group) { FactoryBot.create(:group) }

      let(:final_evaluation_attrs) { FactoryBot.attributes_for(:final_evaluation, :passed, group_id: group.id, student_id: student.id) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :create, params: params

        response
      end

      context 'with valid data' do
        let(:params) { final_evaluation_attrs.merge({student_id: student.id, format: :json}) }

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(final_evaluation:{
            student_id: student.id,
            status: final_evaluation_attrs[:status],
            group: {
              id: group.id,
              name: group.name,
              year: group.year
            }
          })
        end
      end

      context 'with invalid student id' do
        let(:params) { {student_id: -1, group_id: group.id, status: final_evaluation_attrs[:status], format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end

      context 'with invalid group id' do
        let(:params) { {student_id: student.id, group_id: -1, status: final_evaluation_attrs[:status], format: :json} }

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
      let(:final_evaluation_attrs) { FactoryBot.attributes_for(:final_evaluation, :passed, :with_group, student_id: student.id) }

      let(:params) { final_evaluation_attrs.merge({format: :json}) }

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
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      let(:student) { FactoryBot.create(:student) }
      let(:group) { FactoryBot.create(:group) }
      let(:final_evaluation) { FactoryBot.create(:final_evaluation, :passed, group_id: group.id, student_id: student.id) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        patch :update, params: params

        response
      end

      context 'with valid data' do
        let(:final_evaluation_attrs) { FactoryBot.attributes_for(:final_evaluation, :passed, group_id: group.id, student_id: student.id) }
        let(:params) { final_evaluation_attrs.merge({id: final_evaluation.id, student_id: student.id, format: :json}) }

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(final_evaluation:{
            student_id: student.id,
            status: final_evaluation_attrs[:status],
            group: {
              id: group.id,
              name: group.name,
              year: group.year
            }
          })
        end
      end

      context 'with invalid student id' do
        let(:final_evaluation_attrs) { FactoryBot.attributes_for(:final_evaluation, :passed, group_id: group.id, student_id: student.id) }
        let(:params) { {id: final_evaluation.id, student_id: -1, group_id: group.id, status: final_evaluation_attrs[:status], format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end

      context 'with invalid group id' do
        let(:final_evaluation_attrs) { FactoryBot.attributes_for(:final_evaluation, :passed, group_id: -1, student_id: student.id) }
        let(:params) { final_evaluation_attrs.merge({id: final_evaluation.id, student_id: student.id, format: :json}) }

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

      let(:student) { FactoryBot.create(:student) }
      let(:group) { FactoryBot.create(:group) }
      let(:final_evaluation) { FactoryBot.create(:final_evaluation, :passed, group_id: group.id, student_id: student.id) }
      let(:final_evaluation_attrs) { FactoryBot.attributes_for(:final_evaluation, :passed, group_id: group.id, student_id: student.id) }

      let(:params) { final_evaluation_attrs.merge({id: final_evaluation.id, student_id: student.id, group_id: group.id, format: :json}) }

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

  describe 'DELETE destroy' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:student) { FactoryBot.create(:student, :with_evaluation) }
      let!(:final_evaluation) { student.final_evaluations.first }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        delete :destroy, params: params

        response
      end

      context 'with valid student id' do
        let(:params) { {student_id: student.id, id: final_evaluation.id, format: :json} }

        its(:status) { should eq(204) }

        it 'destroy the final_evaluation' do
          expect {
            subject
          }.to change(FinalEvaluation, :count).by(-1)
        end

        it 'destroy the student association with the final_evaluation' do
          expect {
            subject
          }.to change { student.final_evaluations.count }.by(-1)
        end
      end

      context 'with invalid student id' do
        let(:params) { {student_id: -1, id: final_evaluation.id, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end

      context 'with invalid final_evaluation id' do
        let(:params) { {student_id: student.id, id: -1, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'final_evaluation.not_found',
            description: I18n.t('final_evaluation.not_found')
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:student) { FactoryBot.create(:student, :with_evaluation) }
      let(:final_evaluation) { student.final_evaluations.first }
      let(:params) { {student_id: student.id, id: final_evaluation.id, format: :json} }

      subject do
        delete :destroy, params: params

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
