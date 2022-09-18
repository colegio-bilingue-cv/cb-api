class Api::FamilyMembersController < Api::BaseController

  def create
    student = Student.find(params[:student_id])
    family_member = student.family_members.find_or_create_by!(family_member_params)

    response = Panko::Response.create do |r|
      { family_member: r.serializer(family_member, FamilyMemberSerializer) }
    end

    render json: response, status: :created
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
  rescue ActiveRecord::RecordInvalid
    render json: {}, status: :unprocessable_entity
  end

  def update
    student = Student.find(params[:student_id])
    family_member = student.family_members.find(params[:id])

    family_member.update!(family_member_params)

    response = Panko::Response.create do |r|
      { family_member: r.serializer(family_member, FamilyMemberSerializer) }
    end

    render json: response, status: :ok
  rescue ActiveRecord::RecordInvalid
    render json: {}, status: :unprocessable_entity
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
  end

  private

  def family_member_params
    params.require(:family_member).permit(:ci, :role, :full_name, :birthdate, :birthplace, :nationality,
      :first_language, :marital_status, :cellphone, :email,
      :address, :neighborhood, :education_level, :occupation, :workplace,
      :workplace_neighbourhood, :workplace_phone
    )
  end
end
