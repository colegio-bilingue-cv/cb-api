class Api::MeController < Api::BaseController

  def show
    
    response = Panko::Response.create do |r|
      { me: r.serializer(current_user, UserSerializer) }
    end

    render json: response, status: :ok
  end

end
