require 'rails_helper'

RSpec.describe Api::DiscountsController do

  describe 'POST create' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:student) { FactoryBot.create(:student, :with_discount) }
      let(:discount) { student.discounts.first }
      let(:discount_attrs) { discount.attributes }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :create, params: params

        response
      end

      context 'with valid student id' do
        let(:params) { discount_attrs.merge({student_id: student.id, format: :json}) }

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(discount: {
            percentage: discount.percentage,
            explanation: discount.explanation,
            start_date: discount.start_date.to_s,
            end_date: discount.end_date.to_s,
            resolution_description: discount.resolution_description,
            administrative_type: discount.administrative_type
          })
        end
      end

      context 'with invalid student id' do
        let(:params) { {student_id: -1, discount: discount_attrs, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:student) { FactoryBot.create(:student, :with_discount) }
      let(:discount) { student.discounts.first }
      let(:discount_attrs) { discount.attributes }
      let(:params) { {student_id: student.id, discount: discount_attrs, format: :json} }

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
      let(:student) { FactoryBot.create(:student, :with_discount) }
      let(:discount) { student.discounts.first }
      let(:discount_attrs) { discount.attributes }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        patch :update, params: params

        response
      end

      context 'with valid student id' do
        let(:params) { {student_id: student.id, id: discount.id, explanation:'resolution', percentage:'30', format: :json} }

        it 'changes the explanation and percentage' do
          expect {
            subject

            discount.reload
          }.to change(discount, :explanation).to('resolution').and change(discount, :percentage).to(30)
        end

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(discount: {
            percentage: 30,
            explanation: 'resolution',
            start_date: discount.start_date.to_s,
            end_date: discount.end_date.to_s,
            resolution_description: discount.resolution_description,
            administrative_type: discount.administrative_type
          })
        end
      end

      context 'with invalid student id' do
        let(:params) { {student_id: -1, id: discount.id, explanation:'resolution', format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:student) { FactoryBot.create(:student, :with_discount) }
      let(:discount) { student.discounts.first }
      let(:discount_attrs) { discount.attributes }
      let(:params) { {student_id: student.id, id: discount.id, explanation: '1', format: :json} }

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
      let(:student) { FactoryBot.create(:student, :with_discount) }
      let!(:discount) { student.discounts.first }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        delete :destroy, params: params

        response
      end

      context 'with valid student id' do
        let(:params) { {student_id: student.id, id: discount.id, format: :json} }

        its(:status) { should eq(204) }

        it 'destroy the discount' do
          expect {
            subject
          }.to change(Discount, :count).by(-1)
        end

        it 'destroy the student association with the discount' do
          expect {
            subject
          }.to change { student.discounts.count }.by(-1)
        end
      end

      context 'with invalid student id' do
        let(:params) { {student_id: -1, id: discount.id, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end

      context 'with invalid discount id' do
        let(:params) { {student_id: student.id, id: -1, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'discount.not_found',
            description: I18n.t('discount.not_found')
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:student) { FactoryBot.create(:student, :with_discount) }
      let(:discount) { student.discounts.first.id }
      let(:params) { {student_id: student.id, id: discount, format: :json} }

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
