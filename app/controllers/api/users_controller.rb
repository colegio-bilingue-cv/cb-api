class Api::UsersController < Api::BaseController

  def create
    user = User.create!(users_params.except(:role)) do |user|
      user.add_role(users_params[:role])
    end

    response = Panko::Response.create do |r|
      { user: r.serializer(user, UserSerializer) }
    end

    render json: response, status: :created
  end

  def index
    users = User.all

    response = Panko::Response.new(
      users: Panko::ArraySerializer.new(users, each_serializer: UserSerializer)
    )

    render json: response, status: :ok
  end

  def update
    user = User.find(params[:id])
    user.update!(users_params)

    response = Panko::Response.create do |r|
      { user: r.serializer(user, UserSerializer) }
    end

    render json: response, status: :ok
  end

  def show
    user = User.find(params[:id])
    response = Panko::Response.create do |r|
      { user: r.serializer(user, UserWithFullInformationSerializer) }
    end

    render json: response, status: :ok
  end

  def create_document
    user = User.find(params[:user_id])
    document = user.documents.create!(document_params)

    response = Panko::Response.create do |r|
      { document: r.serializer(document, DocumentSerializer) }
    end

    render json: response, status: :created
  end

  def create_complementary_information
    user = User.find(params[:user_id])
    complementary_information = user.complementary_informations.create!(complementary_information_params)

    response = Panko::Response.create do |r|
      { complementary_information: r.serializer(complementary_information, ComplementaryInformationSerializer) }
    end

    render json: response, status: :created
  end

  def create_absence
    user = User.find(params[:user_id])
    absence = user.absences.create!(absence_params)

    response = Panko::Response.create do |r|
      { absence: r.serializer(absence, AbsenceSerializer) }
    end

    render json: response, status: :created
  end

  private

  def users_params
    params.require(:user).permit(:email, :password, :birthdate, :name, :surname, :ci, :address, :role, :starting_date)
  end

  def document_params
    params.permit(:document_type, :certificate, :upload_date)
  end

  def complementary_information_params
    params.permit(:description, :date, :attachment)
  end

  def absence_params
    params.permit(:start_date, :end_date, :reason, :certificate)
  end
end
