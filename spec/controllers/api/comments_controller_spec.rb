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

      context 'with valid student id' do
        let(:params) { {student_id: student.id, comment: comment_attrs, format: :json} }

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(comment: {
            text: comment_attrs.text
          })
        end
      end

      context 'with invalid student id' do
        let(:params) { {student_id: -1, comment: comment_attrs, format: :json} }

        its(:status) { should eq(404) }

        its(:body) { should include_json({}) }
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
        should include_json({})
      end
    end
  end

end
