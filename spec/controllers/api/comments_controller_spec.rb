require 'rails_helper'

RSpec.describe Api::CommentsController do

  describe 'POST create' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:student) { FactoryBot.create(:student) }
      let(:comment_attrs) { FactoryBot.attributes_for(:comment) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :create, params: params

        response
      end

      context 'with valid data' do
        let(:params) { {student_id: student.id, comment: comment_attrs, format: :json} }

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(comment: {
            text: comment_attrs[:text]
          })
        end
      end

      context 'with invalid student id' do
        let(:params) { {student_id: -1, comment: comment_attrs, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end

      context 'with invalid data' do
        let(:params) { {student_id: student.id, comment: { text: '' }, format: :json} }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json(error: {
            key: 'record_invalid',
            description: {
              text: ['no puede estar en blanco']
            }
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:student) { FactoryBot.create(:student, :with_comment) }
      let(:comment) { student.comments.first }
      let(:comment_attrs) { comment.attributes }
      let(:params) { {student_id: student.id, comment: comment_attrs, format: :json} }

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
      let(:student) { FactoryBot.create(:student, :with_comment) }
      let(:comment) {student.comments.first}
      let(:comment_attrs) { FactoryBot.attributes_for(:comment) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        patch :update, params: params

        response
      end

      context 'with valid data' do
        let(:params) { {student_id: student.id, id: comment.id, comment: comment_attrs, format: :json} }

        it 'changes the text of the comment' do
          expect {
            subject

            comment.reload
          }.to change(comment, :text).to(comment_attrs[:text])
        end

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(comment: {
            text: comment_attrs[:text]
          })
        end
      end

      context 'with invalid student id' do
        let(:params) { {student_id: -1, id: comment.id, comment: comment_attrs, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end

      context 'with invalid data' do
        let(:params) { {student_id: student.id, id: comment.id, comment: { text: '' }, format: :json} }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json(error: {
            key: 'record_invalid',
            description: {
              text: ['no puede estar en blanco']
            }
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:student) { FactoryBot.create(:student, :with_comment) }
      let(:comment) { student.comments.first }
      let(:comment_attrs) { comment.attributes }
      let(:params) { {student_id: student.id, id: comment.id, comment: comment_attrs, format: :json} }

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
