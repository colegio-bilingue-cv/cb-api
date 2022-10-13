class Api::CommentsController < Api::BaseController
  def create
    student = Student.find(params[:student_id])
    comment = student.comments.create!(comment_params)

    response = Panko::Response.create do |r|
      { comment: r.serializer(comment, CommentSerializer) }
    end

    render json: response, status: :created
  rescue ActiveRecord::RecordInvalid
    render json: {}, status: :unprocessable_entity
  end

  def update
    student = Student.find(params[:student_id])
    comment = student.comments.find(params[:id])

    comment.update!(comment_params)

    response = Panko::Response.create do |r|
      { comment: r.serializer(comment, CommentSerializer) }
    end

    render json: response, status: :ok
  rescue ActiveRecord::RecordInvalid
    render json: {}, status: :unprocessable_entity
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
