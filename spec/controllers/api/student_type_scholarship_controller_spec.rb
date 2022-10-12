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

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end

      context 'with invalid type scholarship id' do
        let(:params) { {student_type_scholarship: {student_id: student.id, type_scholarship_id: -1}, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'type_scholarship.not_found',
            description: I18n.t('type_scholarship.not_found')
          })
        end
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
      let(:type_scholarship) { FactoryBot.create(:type_scholarship) }
  
      let(:student_type_scholarship) { FactoryBot.create(:student_type_scholarship, student_id: student.id, type_scholarship_id: type_scholarship.id) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        patch :update, params: params

        response
      end

      context 'with valid data' do
       let(:params) do
          { student_type_scholarship:{student_id: student_type_scholarship.student_id,
            type_scholarship_id: type_scholarship2.id },
            id: student_type_scholarship.id,
            format: :json }
        end
        let(:type_scholarship2) { FactoryBot.create(:type_scholarship) }

        it 'changes the type_scholarship' do
          expect {
            subject

            student_type_scholarship.reload
          }.to change(student_type_scholarship, :type_scholarship_id).to(type_scholarship2.id)
        end        
        
        its(:status) { should eq(200) }

        its(:body) do
          should include_json(student_type_scholarship: {
            id: student_type_scholarship.id,
            student_id: student_type_scholarship.student_id,
            type_scholarship_id: type_scholarship2.id,
            date: Date.today.to_s
          })
        end
      end

      context 'with invalid id' do
        let(:params) do
          { student_type_scholarship: {student_id: student_type_scholarship.student_id,
            type_scholarship_id: student_type_scholarship.type_scholarship_id}, id: -1,
            format: :json }
        end

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student_type_scholarship.not_found',
            description: I18n.t('student_type_scholarship.not_found')
          })
        end
      end

      context 'with invalid data' do
        let(:params) do { student_type_scholarship: {
          student_id: -1,
          type_scholarship_id: student_type_scholarship.type_scholarship_id}, id: student_type_scholarship.id,
          format: :json } 
      end

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
      let(:student) { FactoryBot.create(:student) }
      let(:type_scholarship) { FactoryBot.create(:type_scholarship) }
  
      let(:student_type_scholarship) { FactoryBot.create(:student_type_scholarship, student_id: student.id, type_scholarship_id: type_scholarship.id) }

      let(:params) do
        { student_type_scholarship:{student_id: student_type_scholarship.student_id,
          type_scholarship_id: student_type_scholarship.type_scholarship_id },
          id: student_type_scholarship.id,
          format: :json }
      end

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
end
