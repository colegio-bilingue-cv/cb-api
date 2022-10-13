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
        let(:params) { {student_id: student.id, discount: discount_attrs, format: :json} }

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

end