class Api::PrincipalsController < Api::BaseController
    def index
      principals = User.with_role(:principal)
 
      response = Panko::Response.new(
        principals: Panko::ArraySerializer.new(principals, each_serializer: PrincipalSerializer)
      )
 
      render json: response, status: :ok
    end
end
