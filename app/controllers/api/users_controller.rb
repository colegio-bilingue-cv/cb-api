class Api::UsersController < Api::BaseController

  def create
    user = User.create!(users_params.except(:role))
    user.add_role(users_params[:role])

    response = Panko::Response.create do |r|
      { user: r.serializer(user, UserSerializer) }
    end

    render json: response, status: :created
  end

  private

  def users_params
    params.require(:user).permit(:email, :password, :birthdate, :name, :surname, :ci, :address, :role)
  end

end
