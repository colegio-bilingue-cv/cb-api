require 'rails_helper'

RSpec.describe Api::CommentsController do

  describe 'POST create' do
    let(:student) { FactoryBot.create(:student, :with_comment) }
    let(:comment) { student.comments.first }
    let(:comment_attrs) { comment.attributes }

    context 'with valid student id' do
      let(:params) { {student_id: student.id, comment: comment_attrs, format: :json} }

      subject do
        post :create, params: params

        response
      end

      its(:status) { should eq(201) }

      its(:body) do
        should include_json(comment: {
          text: comment.text
        })
      end
    end

    context 'with invalid student id' do
      let(:invalid_params) { {student_id: -1, comment: comment_attrs, format: :json} }

      subject do
        post :create, params: invalid_params

        response
      end

      its(:status) { should eq(404) }

      its(:body) { should include_json({}) }
    end

  end

end