require 'rails_helper'

RSpec.describe Api::StudentPaymentMethodsController do

  describe 'POST create' do
    let(:student_payment_method) { FactoryBot.build(:student_payment_method, :with_student, :with_payment_method) }
    let(:student_payment_method_attrs) { student_payment_method.attributes }
    
    let(:student) { student_payment_method_attrs.student }
    let(:payment_method) { student_payment_method_attrs.payment_method }

    context 'with valid data' do
      let(:params) { {student_id: student.id, payment_method_id: payment_method.id, student_payment_method: student_payment_method_attrs, format: :json} }

      subject do
        post :create, params: params

        response
      end

      its(:status) { should eq(201) }

      its(:body) do
        should include_json(student_payment_method: {
          student_id: student_payment_method.student_id,
          payment_method_id: student_payment_method.payment_method_id,
          year: student_payment_method.year
        })
      end
    end

    context 'with invalid data' do
      let(:invalid_student_payment_method { FactoryBot.build(:student_payment_method, :with_invalid_data, :with_student, :with_payment_method) }
      let(:invalid_payment_method_attrs) { invalid_student_payment_method.attributes }

      let(:student) { invalid_student_payment_method.student}
      let(:payment_method) { invalid_student_payment_method_attrs.payment_method}
      
      let(:invalid_params) { {student_id: student.id, payment_method_id: payment_method.id, student_payment_method: invalid_student_payment_method_attrs, format: :json} }

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
      let(:invalid_params) { {student_id: -1, payment_method_id: payment_method.id, student_payment_method: student_payment_method_attrs, format: :json} }

      subject do
        post :create, params: invalid_params

        response
      end

      its(:status) { should eq(404) }

      its(:body) { should include_json({}) }
    end

    context 'with invalid payment_method id' do
      let(:invalid_params) { {payment_method_id: -1, student_payment_method: student_payment_method_attrs, format: :json} }

      subject do
        post :create, params: invalid_params

        response
      end

      its(:status) { should eq(404) }

      its(:body) { should include_json({}) }
    end
  end

end
