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

  private

  def users_params
    params.require(:user).permit(:email, :password, :birthdate, :name, :surname, :ci, :address, :role, :starting_date)
  end

end
