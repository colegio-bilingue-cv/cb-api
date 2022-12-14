require 'rails_helper'

RSpec.describe Api::IntermediateEvaluationsController do

  describe 'POST create' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      let(:student) { FactoryBot.create(:student) }
      let(:group) { FactoryBot.create(:group) }

      let(:intermediate_evaluation_attrs) { FactoryBot.attributes_for(:intermediate_evaluation, group_id: group.id) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :create, params: params

        response
      end

      context 'with valid data' do
        let(:params) { intermediate_evaluation_attrs.merge({student_id: student.id, format: :json}) }

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(intermediate_evaluation:{
            student_id: student.id,
            starting_month: intermediate_evaluation_attrs[:starting_month].to_s,
            ending_month: intermediate_evaluation_attrs[:ending_month].to_s,
            group: {
              id: group.id,
              name: group.name,
              year: group.year
            }
          })
        end
      end

      context 'with opposite dates' do
        let(:intermediate_evaluation_with_opposite_dates_attrs) { FactoryBot.attributes_for(:intermediate_evaluation, starting_month: Date.current.next_month, ending_month: Date.current, group_id: group.id, student_id: student.id) }
        let(:params) { intermediate_evaluation_with_opposite_dates_attrs.merge({student_id: student.id, format: :json}) }

        its(:status) { should eq(422) }

        its(:body) do
            should include_json(error: {
              key: 'record_invalid',
              description: {
                starting_month: ['El mes de inicio no puede ser posterior al mes final']
              }
            })
        end
      end


      context 'with invalid student id' do
        let(:params) { {student_id: -1, group_id: group.id, starting_month: intermediate_evaluation_attrs[:starting_month], ending_month: intermediate_evaluation_attrs[:ending_month], format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end

      context 'with invalid group id' do
        let(:params) { {student_id: student.id, group_id: -1, starting_month: intermediate_evaluation_attrs[:starting_month], ending_month: intermediate_evaluation_attrs[:ending_month], format: :json} }

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
      let(:intermediate_evaluation_attrs) { FactoryBot.attributes_for(:intermediate_evaluation, :with_group, student_id: student.id) }

      let(:params) { intermediate_evaluation_attrs.merge({student_id: intermediate_evaluation_attrs[:student_id], format: :json}) }

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
      let(:intermediate_evaluation) { FactoryBot.create(:intermediate_evaluation, student_id: student.id, group_id: group.id) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        patch :update, params: params

        response
      end

      context 'with valid data' do
        let(:intermediate_evaluation_attrs) { FactoryBot.attributes_for(:intermediate_evaluation, group_id: group.id) }
        let(:params) { intermediate_evaluation_attrs.merge({id: intermediate_evaluation.id, student_id: student.id, group_id: group.id, format: :json}) }

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(intermediate_evaluation:{
            student_id: student.id,
            starting_month: intermediate_evaluation_attrs[:starting_month].to_s,
            ending_month: intermediate_evaluation_attrs[:ending_month].to_s,
            group: {
              id: group.id,
              name: group.name,
              year: group.year
            }
          })
        end
      end

      context 'with opposite dates' do
        let(:intermediate_evaluation_with_opposite_dates_attrs) { FactoryBot.attributes_for(:intermediate_evaluation, starting_month: Date.current.next_month, ending_month: Date.current, group_id: group.id, student_id: student.id) }
        let(:params) { intermediate_evaluation_with_opposite_dates_attrs.merge({id: intermediate_evaluation.id, student_id: student.id, format: :json}) }

        its(:status) { should eq(422) }

        its(:body) do
            should include_json(error: {
              key: 'record_invalid',
              description: {
                starting_month: ['El mes de inicio no puede ser posterior al mes final']
              }
            })
        end
      end

      context 'with invalid student id' do
        let(:intermediate_evaluation_attrs) { FactoryBot.attributes_for(:intermediate_evaluation, group_id: group.id) }
        let(:params) { intermediate_evaluation_attrs.merge({id: intermediate_evaluation.id, student_id: -1, group_id: group.id, format: :json}) }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end

      context 'with invalid group id' do
        let(:intermediate_evaluation_attrs) { FactoryBot.attributes_for(:intermediate_evaluation, group_id: -1) }
        let(:params) { intermediate_evaluation_attrs.merge({id: intermediate_evaluation.id, student_id: student.id, format: :json}) }

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
      let(:intermediate_evaluation) { FactoryBot.create(:intermediate_evaluation, student_id: student.id, group_id: group.id) }
      let(:intermediate_evaluation_attrs) { FactoryBot.attributes_for(:intermediate_evaluation, group_id: group.id) }

      let(:params) { intermediate_evaluation_attrs.merge({id: intermediate_evaluation.id,student_id: student.id, group_id: group.id, format: :json}) }

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
      let!(:intermediate_evaluation) { student.intermediate_evaluations.first }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        delete :destroy, params: params

        response
      end

      context 'with valid student id' do
        let(:params) { {student_id: student.id, id: intermediate_evaluation.id, format: :json} }

        its(:status) { should eq(204) }

        it 'destroy the intermediate_evaluation' do
          expect {
            subject
          }.to change(IntermediateEvaluation, :count).by(-1)
        end

        it 'destroy the student association with the intermediate_evaluation' do
          expect {
            subject
          }.to change { student.intermediate_evaluations.count }.by(-1)
        end
      end

      context 'with invalid student id' do
        let(:params) { {student_id: -1, id: intermediate_evaluation.id, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end

      context 'with invalid intermediate_evaluation id' do
        let(:params) { {student_id: student.id, id: -1, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'intermediate_evaluation.not_found',
            description: I18n.t('intermediate_evaluation.not_found')
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:student) { FactoryBot.create(:student, :with_evaluation) }
      let(:intermediate_evaluation) { student.intermediate_evaluations.first}
      let(:params) { {student_id: student.id, id: intermediate_evaluation.id, format: :json} }

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
