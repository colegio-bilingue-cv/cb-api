class Api::RelevantEventsController < Api::BaseController
  def create
    student = Student.find(params[:student_id])

    relevant_event = student.relevant_events.create!(relevant_event_params.merge(user_id: current_user.id))

    response = Panko::Response.create do |r|
      { relevant_event: r.serializer(relevant_event, RelevantEventSerializer) }
    end

    render json: response, status: :created
  end

  def update
    student = Student.find(params[:student_id])
    relevant_event = student.relevant_events.find(params[:id])

    relevant_event.update!(relevant_event_params)

    response = Panko::Response.create do |r|
      { relevant_event: r.serializer(relevant_event, RelevantEventSerializer) }
    end

    render json: response, status: :ok
  end

  def destroy
    student = Student.find(params[:student_id])
    relevant_event = student.relevant_events.destroy(params[:id])

    head :no_content
  end

  private

  def relevant_event_params
    params.permit(:title, :description, :date, :event_type, :attachment)
  end

end
