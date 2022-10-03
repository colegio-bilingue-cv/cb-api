require 'rails_helper'

RSpec.describe Api::StudentTypeScholarshipsController do

  describe 'POST create' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:type_scholarship) { FactoryBot.create(:type_scholarship) }
      let(:student) { FactoryBot.create(:student) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :create, params: params

        response
      end

      context 'with valid data' do
        let(:params) { { student_type_scholarship: {type_scholarship_id: type_scholarship.id, student_id: student.id}, format: :json} }

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(student_type_scholarship: {
            student_id: student.id,
            type_scholarship_id: type_scholarship.id
          })
        end
      end

      context 'with invalid student id' do
        let(:params) { {student_type_scholarship: {student_id: -1, type_scholarship_id: type_scholarship.id}, format: :json} }

        its(:status) { should eq(422) }

        its(:body) { should include_json({}) }
      end

      context 'with invalid type scholarship id' do
        let(:params) { {student_type_scholarship: {student_id: student.id, type_scholarship_id: -1}, format: :json} }

        its(:status) { should eq(422) }

        its(:body) { should include_json({}) }
      end
    end

    context 'when user is not signed in' do
      let(:type_scholarship) { FactoryBot.create(:type_scholarship) }
      let(:student) { FactoryBot.create(:student) }
      let(:params) { {student_type_scholarship: {student_id: student.id, type_scholarship_id: -1}, format: :json} }

      subject do
        post :create, params: params

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json({})
      end
    end

  end
end
