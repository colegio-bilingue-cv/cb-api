class Api::FamilyMembersController < Api::BaseController

  def create
    student = Student.find(params[:student_id])
    family_member = FamilyMember.find_or_initialize_by(ci:family_member_params[:ci])
    family_member.role = family_member_params[:role]
    family_member.full_name = family_member_params[:full_name]
    family_member.birthdate = family_member_params[:birthdate]
    family_member.birthplace = family_member_params[:birthplace]
    family_member.nationality = family_member_params[:nationality]
    family_member.first_language = family_member_params[:first_language]
    family_member.marital_status = family_member_params[:marital_status]
    family_member.cellphone = family_member_params[:cellphone]
    family_member.email = family_member_params[:email]
    family_member.address = family_member_params[:address]
    family_member.neighborhood = family_member_params[:neighborhood]
    family_member.education_level = family_member_params[:education_level]
    family_member.occupation = family_member_params[:occupation]
    family_member.workplace = family_member_params[:workplace]
    family_member.workplace_neighbourhood = family_member_params[:workplace_neighbourhood]
    family_member.workplace_phone = family_member_params[:workplace_phone]

    family_member.save!

    student.family_members << family_member

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
