require 'rails_helper'

RSpec.describe Api::IntermediateEvaluationController do

  describe 'POST create' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      let(:student) { FactoryBot.create(:student) }
      let(:group) { FactoryBot.create(:group) }

      let(:intermediate_evaluation_attrs) { FactoryBot.attributes_for(:intermediate_evaluation, group_id: group.id, student_id: student.id) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :create, params: params

        response
      end

      context 'with valid data' do
        let(:params) { { student_id: student.id, intermediate_evaluation: intermediate_evaluation_attrs , format: :json} }

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(intermediate_evaluation:{
            student_id: student.id,
            group_id: group.id,
            starting_month: intermediate_evaluation_attrs[:starting_month].to_s,
            ending_month: intermediate_evaluation_attrs[:ending_month].to_s,
            group_name: group.name,
            year: group.year
          })
        end
      end

      context 'with opposite dates' do
        let(:intermediate_evaluation_with_opposite_dates_attrs) { FactoryBot.attributes_for(:intermediate_evaluation, starting_month: Date.current.next_month, ending_month: Date.current, group_id: group.id, student_id: student.id) }
        let(:params) { { student_id: student.id, intermediate_evaluation: intermediate_evaluation_with_opposite_dates_attrs , format: :json} }

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
        let(:params) { {student_id: student.id, intermediate_evaluation: {student_id: -1, group_id: group.id, starting_month: intermediate_evaluation_attrs[:starting_month], ending_month: intermediate_evaluation_attrs[:ending_month]}, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end

      context 'with invalid group id' do
        let(:params) { {student_id: student.id, intermediate_evaluation: {student_id: student.id, group_id: -1, starting_month: intermediate_evaluation_attrs[:starting_month], ending_month: intermediate_evaluation_attrs[:ending_month]}, format: :json} }

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

      let(:params) { {student_id: intermediate_evaluation_attrs[:student_id], intermediate_evaluation: intermediate_evaluation_attrs, format: :json} }

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
