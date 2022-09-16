class Api::FamilyMembersController < Api::BaseController

  def create
    student = Student.find(params[:student_id])
    student.family_members.create!(family_member_params)

    render json: FamilyMemberSerializer.new.serialize_to_json(family_member), status: :created
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
  rescue ActiveRecord::RecordInvalid
    render json: {}, status: :unprocessable_entity
  end

  private

  def family_members_params
    params.require(:family_member).permit(:ci, :role, :full_name, :birthdate, :birthplace, :nationality,
      :first_language, :marital_status, :cellphone, :email,
      :address, :neighborhood, :education_level, :occupation, :workplace,
      :workplace_neighbourhood, :workplace_phone
    )
  end
end
