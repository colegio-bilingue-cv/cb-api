class Api::FamilyMembersController < Api::BaseController

  def create
    student = Student.find(params[:student_id])
    family_member = FamilyMember.find_or_initialize_by(ci: family_member_params[:ci])
    family_member.assign_attributes(family_member_params)

    family_member.save!

    student.family_members << family_member

    response = Panko::Response.create do |r|
      { family_member: r.serializer(family_member, FamilyMemberSerializer) }
    end

    render json: response, status: :created
  end

  def update
    student = Student.find(params[:student_id])
    family_member = student.family_members.find(params[:id])

    family_member.update!(family_member_params)

    response = Panko::Response.create do |r|
      { family_member: r.serializer(family_member, FamilyMemberSerializer) }
    end

    render json: response, status: :ok
  end

  private

  def family_member_params
    params.require(:family_member).permit(:ci, :role, :full_name, :birthdate, :birthplace, :nationality,
      :first_language, :marital_status, :cellphone, :email,
      :address, :neighborhood, :education_level, :occupation, :workplace,
      :workplace_neighbourhood, :workplace_phone, :workplace_address
    )
  end
end
