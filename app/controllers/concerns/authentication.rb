module Authentication
  extend ActiveSupport::Concern

  included do

    # Set the current user based on the Authentication header if that
    #   header is not present that means that the user is not
    #   authenticated.
    before_action :require_signed_in_user!

  end

  # Returns the signed in user or nil if no user is signed in.
  #
  # @return [User]
  def current_user
    @current_user
  end

  # Returns the payload from the Token class decoded form the header.
  #
  # @return [Hash]
  def current_user_token
    @current_user_token
  end

  # Returns true if the user is signed in false otherwise.
  #
  # @return [Boolean]
  def user_signed_in?
    !!current_user
  end

  # Returns an error response when the user is not signed in.
  #   This method can be used as a before_action.
  #
  # @example
  #
  #   class SomeGreatController < AplicationController
  #
  #     before_action :require_signed_in_user!, only: [:show]
  #
  #     def show
  #       ...
  #     end
  #
  #   end
  def require_signed_in_user!
    if request.headers['Authorization'].present?
      set_current_user
    else
      response = Panko::Response.create do |r|
        { error: r.serializer(ErrorMessage.build_required_signed_in, ErrorSerializer) }
      end

      render json: response, status: :forbidden
    end
  end

  # Returns an error response when the user is not signed in.
  #   This method can be used as a before_action.
  #
  # @example
  #
  #   class SomeGreatController < AplicationController
  #
  #     before_action :require_signed_in_user!, only: [:show]
  #
  #     def show
  #       ...
  #     end
  #
  #   end
  def require_no_signed_in_user!
    if request.headers['Authorization'].present?
      response = Panko::Response.create do |r|
        { error: r.serializer(ErrorMessage.build_required_not_signed_in, ErrorSerializer) }
      end

      render json: response, status: :forbidden
    end
  end

  private

  # @private
  def set_current_user
    raise RequiredSignedInError unless request.headers['Authorization'].present?

    token = get_token_from_header

    @current_user_token = JWT::Token.new(token)

    @current_user_token.validate_token!

    @current_user = User.find(@current_user_token.user_id)
  rescue InvalidHeaderError => e
    response = Panko::Response.create do |r|
      { error: r.serializer(ErrorMessage.build_invalid_token(e), ErrorSerializer) }
    end

    render json: response, status: :forbidden
  rescue RequiredSignedInError
    response = Panko::Response.create do |r|
      { error: r.serializer(ErrorMessage.build_required_signed_in, ErrorSerializer) }
    end

    render json: response, status: :forbidden
  end

  def get_token_from_header
    raw_header = request.headers['Authorization'].to_s.split(' ')
    raise InvalidHeaderError if raw_header.count != 2 || raw_header.first != 'Bearer'

    raw_header.second
  end

end
