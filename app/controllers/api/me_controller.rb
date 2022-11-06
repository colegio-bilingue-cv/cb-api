class Api::MeController < Api::BaseController

  def show

    response = Panko::Response.create do |r|
      { me: r.serializer(current_user, UserSerializer) }
    end

    render json: response, status: :ok
  end

  def update
    current_user.update!(me_params)

    response = Panko::Response.create do |r|
      { user: r.serializer(current_user, UserSerializer) }
    end

    render json: response, status: :ok
  end

  def password
    current_user.update!(me_password_params)

    response = Panko::Response.create do |r|
      { user: r.serializer(current_user, UserSerializer) }
    end

    render json: response, status: :ok
  end

  def create_document
    document = current_user.documents.create!(document_params)

    response = Panko::Response.create do |r|
      { document: r.serializer(document, DocumentSerializer) }
    end

    render json: response, status: :created
  end

  private

  def me_params
    params.require(:user).permit(:birthdate, :name, :surname, :ci, :address)
  end

  def me_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def document_params
    params.permit(:document_type, :certificate, :upload_date)
  end
end
