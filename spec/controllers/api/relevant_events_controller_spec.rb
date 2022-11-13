require 'rails_helper'

RSpec.describe Api::RelevantEventsController do

  describe 'POST create' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:student) { FactoryBot.create(:student) }
      let(:relevant_event_attrs) { FactoryBot.attributes_for(:relevant_event, :family_situation) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :create, params: params

        response
      end

      context 'with valid data' do
        let(:params) { relevant_event_attrs.merge({student_id: student.id, format: :json}) }

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(relevant_event: {
            title: relevant_event_attrs[:title],
            description: relevant_event_attrs[:description],
            date: relevant_event_attrs[:date].to_s,
            event_type: relevant_event_attrs[:event_type],
            user:{
              ci: user.ci.to_s,
              name: user.name,
              surname: user.surname,
              birthdate: user.birthdate.to_s,
              address: user.address,
              email: user.email,
              starting_date: user.starting_date.to_s
            }
          })
        end
      end

      context 'with invalid student id' do
        let(:params) { {student_id: -1, relevant_event: relevant_event_attrs, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end

      context 'with invalid data' do
        let(:params) { {student_id: student.id, relevant_event: { date: '' }, format: :json} }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json(error: {
            key: 'record_invalid',
            description: {
              date: ['no puede estar en blanco']
            }
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:student) { FactoryBot.create(:student, :with_relevant_event) }
      let(:relevant_event) { student.relevant_events.first }
      let(:relevant_event_attrs) { relevant_event.attributes }
      let(:params) { {student_id: student.id, relevant_event: relevant_event_attrs, format: :json} }

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
      let(:student) { FactoryBot.create(:student, :with_relevant_event) }
      let(:relevant_event) {student.relevant_events.first}
      let(:relevant_event_attrs) { FactoryBot.attributes_for(:relevant_event) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        patch :update, params: params

        response
      end

      context 'with valid data' do

        let(:params) { {student_id: student.id, id: relevant_event.id, title:'Nuevo title', format: :json} }
        it 'changes the title of the relevant_event' do
          expect {
            subject

            relevant_event.reload
          }.to change(relevant_event, :title).to('Nuevo title')
        end

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(relevant_event: {
            title: 'Nuevo title'
          })
        end
      end

      context 'with invalid student id' do
        let(:params) { {student_id: -1, id: relevant_event.id, relevant_event: relevant_event_attrs, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end

      context 'with invalid data' do
        let(:params) { {student_id: student.id, id: relevant_event.id, date: nil , format: :json} }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json(error: {
            key: 'record_invalid',
            description: {
              date: ['no puede estar en blanco']
            }
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:student) { FactoryBot.create(:student, :with_relevant_event) }
      let(:relevant_event) { student.relevant_events.first }
      let(:relevant_event_attrs) { relevant_event.attributes }
      let(:params) { {student_id: student.id, id: relevant_event.id, relevant_event: relevant_event_attrs, format: :json} }

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
      let(:student) { FactoryBot.create(:student, :with_relevant_event) }
      let!(:relevant_event) { student.relevant_events.first }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        delete :destroy, params: params

        response
      end

      context 'with valid student id' do
        let(:params) { {student_id: student.id, id: relevant_event.id, format: :json} }

        its(:status) { should eq(204) }

        it 'destroy the relevant_event' do
          expect {
            subject
          }.to change(RelevantEvent, :count).by(-1)
        end

        it 'destroy the student association with the relevant_event' do
          expect {
            subject
          }.to change { student.relevant_events.count }.by(-1)
        end
      end

      context 'with invalid student id' do
        let(:params) { {student_id: -1, user_id:user.id, id: relevant_event.id, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end

      context 'with invalid relevant_event id' do
        let(:params) { {student_id: student.id, user_id: user.id, id: -1, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'relevant_event.not_found',
            description: I18n.t('relevant_event.not_found')
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:student) { FactoryBot.create(:student, :with_relevant_event) }
      let!(:relevant_event) {student.relevant_events.first}

      let(:params) { {student_id: student.id, user_id: user.id, id: relevant_event.id, format: :json} }

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
