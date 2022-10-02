class Api::AuthController < Api::BaseController
  before_action :require_no_signed_in_user!, only: [:sign_in]
  skip_before_action :require_signed_in_user!, only: [:sign_in]

  def sign_in
    user = User.sign_in(email: params[:email], password: params[:password])

    if user.valid?
      result = Panko::Response.create do |r|
        { user: r.serializer(user, UserSerializer) }
      end

      response.set_header('Authorization', "Bearer #{JWT::Token.generate_for(user.id)}")

      render json: result, status: :ok
    else
      render json: {errors: user.errors}, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid
    render json: {}, status: :unauthorized
  end

  def sign_out
    AllowlistedJwt.find_by(user_id: current_user.id, jti: current_user_token.jti).destroy

    result = Panko::Response.create do |r|
      { user: r.serializer(current_user, UserSerializer) }
    end

    render json: result, status: :ok
  rescue ActiveRecord::RecordInvalid
    render json: {}, status: :unauthorized
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
  end
end
