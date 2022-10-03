require 'rails_helper'

RSpec.describe Api::StudentPaymentMethodsController do

  describe 'POST create' do
    let(:user) { FactoryBot.create(:user) }
    let(:student) { FactoryBot.create(:student) }
    let(:payment_method) { FactoryBot.create(:payment_method, method: Faker::Music::Prince.album) }

    let(:student_payment_method) { FactoryBot.build(:student_payment_method, student_id: student.id, payment_method_id: payment_method.id) }

    let(:student_payment_method_attrs) { student_payment_method.attributes }

    context 'when user is signed in' do
      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :create, params: params

        response
      end

      context 'with valid data' do
        let(:params) { {student_payment_method: student_payment_method_attrs, format: :json} }

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(student_payment_method: {
            student_id: student_payment_method.student_id,
            payment_method_id: student_payment_method.payment_method_id,
            year: student_payment_method.year.to_s
          })
        end
      end

      context 'with invalid data' do
        let(:params) { {student_payment_method: {student_id: student.id, payment_method_id: payment_method.id, year: nil}, format: :json} }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json({})
        end
      end

      context 'with invalid student id' do
        let(:invalid_student_payment_method_attrs) { {student_id: -1, payment_method_id: payment_method.id, year: student_payment_method.year} }

        let(:params) { {student_payment_method: invalid_student_payment_method_attrs, format: :json} }

        its(:status) { should eq(422) }

        its(:body) { should include_json({}) }
      end

      context 'with invalid payment_method id' do
        let(:invalid_student_payment_method_attrs) { {student_id: student.id, payment_method_id: -1, year: student_payment_method.year} }

        let(:params) { {student_payment_method: invalid_student_payment_method_attrs, format: :json} }

        its(:status) { should eq(422) }

        its(:body) { should include_json({}) }
      end
    end

    context 'when user is not signed in' do
      let(:params) { {student_payment_method: student_payment_method_attrs, format: :json} }

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
