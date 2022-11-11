require 'rails_helper'

RSpec.describe Api::AnswersController do

  describe 'POST create' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      let(:student) { FactoryBot.create(:student) }
      let(:group) { FactoryBot.create(:group) }
      let(:question) { FactoryBot.create(:question) }

      let(:answer_attrs) { FactoryBot.attributes_for(:answer) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :create, params: params

        response
      end

      context 'with valid data' do
        let(:params) { { answer: answer_attrs.merge(question_id: question.id), student_id: student.id, format: :json } }

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(answer: {
            answer: answer_attrs[:answer],
            question: {
              id: question.id,
              text: question.text
            },
            student: {
              ci: student.ci,
              name: student.name,
              surname: student.surname,
              birthplace: student.birthplace.to_s,
              birthdate: student.birthdate.to_s,
              nationality: student.nationality,
              schedule_start: student.schedule_start,
              schedule_end: student.schedule_end,
              tuition: student.tuition,
              reference_number: student.reference_number,
              office: student.office,
              status: student.status,
              first_language: student.first_language,
              address: student.address,
              neighborhood: student.neighborhood,
              medical_assurance: student.medical_assurance,
              emergency: student.emergency,
              vaccine_expiration: student.vaccine_expiration.to_s,
              vaccine_name: student.vaccine_name,
              phone_number: student.phone_number,
              inscription_date: student.inscription_date.to_s,
              starting_date: student.starting_date.to_s,
              contact: student.contact,
              contact_phone: student.contact_phone
            }
          })
        end
      end

      context 'with invalid student id' do
        let(:params) { { answer: answer_attrs.merge(question_id: question.id), student_id: -1, format: :json } }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end

      context 'with invalid question id' do
        let(:params) { { answer: answer_attrs.merge(question_id: -1), student_id: student.id, format: :json } }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'question.not_found',
            description: I18n.t('question.not_found')
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:student) { FactoryBot.create(:student) }
      let(:group) { FactoryBot.create(:group) }
      let(:question) { FactoryBot.create(:question) }

      let(:answer_attrs) { FactoryBot.attributes_for(:answer) }
      let(:params) { { answer: answer_attrs.merge(question_id: question.id), student_id: student.id, format: :json } }

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
      let(:question) { FactoryBot.create(:question) }
      let(:answer) { FactoryBot.create(:answer, student_id: student.id, question_id: question.id) }
      let(:new_answer) { FactoryBot.attributes_for(:answer) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        patch :update, params: params

        response
      end

      context 'with valid data' do
        let(:params) { { answer: new_answer, id: answer.id, student_id: student.id, format: :json } }

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(answer: {
            answer: new_answer[:answer],
            question: {
              id: question.id,
              text: question.text
            },
            student: {
              ci: student.ci,
              name: student.name,
              surname: student.surname,
              birthplace: student.birthplace.to_s,
              birthdate: student.birthdate.to_s,
              nationality: student.nationality,
              schedule_start: student.schedule_start,
              schedule_end: student.schedule_end,
              tuition: student.tuition,
              reference_number: student.reference_number,
              office: student.office,
              status: student.status,
              first_language: student.first_language,
              address: student.address,
              neighborhood: student.neighborhood,
              medical_assurance: student.medical_assurance,
              emergency: student.emergency,
              vaccine_expiration: student.vaccine_expiration.to_s,
              vaccine_name: student.vaccine_name,
              phone_number: student.phone_number,
              inscription_date: student.inscription_date.to_s,
              starting_date: student.starting_date.to_s,
              contact: student.contact,
              contact_phone: student.contact_phone
            }
          })
        end
      end

      context 'with invalid student id' do
        let(:params) { { answer: new_answer, id: answer.id, student_id: -1, format: :json } }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end

      context 'with invalid question id' do
        let(:params) { { answer: new_answer, id: -1, student_id: student.id, format: :json } }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'answer.not_found',
            description: I18n.t('answer.not_found')
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:student) { FactoryBot.create(:student) }
      let(:group) { FactoryBot.create(:group) }
      let(:question) { FactoryBot.create(:question) }
      let(:answer) { FactoryBot.create(:answer, student_id: student.id, question_id: question.id) }

      let(:new_answer) { FactoryBot.attributes_for(:answer) }
      let(:params) { { answer: new_answer, student_id: student.id, id: answer.id, format: :json } }

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
