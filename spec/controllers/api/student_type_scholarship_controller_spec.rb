require 'rails_helper'

RSpec.describe Api::StudentTypeScholarshipsController do

  describe 'POST create' do
    let(:student_type_scholarship) { FactoryBot.build(:student_type_scholarship, :with_student, :with_type_scholarship) }
    let(:student_type_scholarship_attrs) { student_type_scholarship.attributes }
    let(:student) { student_type_scholarship_attrs.students.first }
    let(:type_scholarship) { student_type_scholarship_attrs.type_scholarship.first }


    context 'with valid data' do
      let(:params) { {student_id: student.id, type_scholarship_id: type_scholarship.id, student_type_scholarship: student_type_scholarship_attrs, format: :json} }

      subject do
        post :create, params: params

        response
      end

      its(:status) { should eq(201) }

      its(:body) do
        should include_json(student_type_scholarship: {
        })
      end
    end

    context 'with invalid data' do
      let(:invalid_student_type_scholarship) { FactoryBot.build(:student_type_scholarship, :with_invalid_data, :with_student, :with_type_scholarship) }
      let(:invalid_student_type_scholarship_attrs) { invalid_student_type_scholarship.attributes }
      let(:student) { invalid_student_type_scholarship.students.first }
      let(:type_scholarship) { invalid_student_type_scholarship.type_scholarship.first }

      let(:invalid_params) { {student_id: student.id, type_scholarship_id: type_scholarship.id, student_type_scholarship: invalid_student_type_scholarship_attrs, format: :json} }

      subject do
        post :create, params: invalid_params

        response
      end

      its(:status) { should eq(422) }

      its(:body) do
        should include_json({})
      end
    end

    context 'with invalid student id' do
      let(:invalid_params) { {student_id: -1, student_type_scholarship: student_type_scholarship_attrs, format: :json} }

      subject do
        post :create, params: invalid_params

        response
      end

      its(:status) { should eq(404) }

      its(:body) { should include_json({}) }
    end

    context 'with invalid type scholarship id' do
      let(:invalid_params) { {type_scholarship_id: -1, student_type_scholarship: student_type_scholarship_attrs, format: :json} }

      subject do
        post :create, params: invalid_params

        response
      end

      its(:status) { should eq(404) }

      its(:body) { should include_json({}) }
    end

  end
end
