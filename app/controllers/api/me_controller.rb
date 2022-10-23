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

  def me_params
    params.require(:user).permit(:birthdate, :name, :surname, :ci, :address)
  end
end
