class Api::BaseController < ApplicationController
  include Authentication

  respond_to :json

  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  rescue_from InvalidCurrentPasswordError, with: :handle_invalid_current_password
  rescue_from NoMatchPasswordError, with: :handle_no_match_password

  protected

  def handle_record_invalid(exception)
    response = Panko::Response.create do |r|
      { error: r.serializer(ErrorMessage.build_record_invalid(exception), ErrorSerializer) }
    end

    render json: response, status: :unprocessable_entity
  end

  def handle_record_not_found(exception)
    response = Panko::Response.create do |r|
      { error: r.serializer(ErrorMessage.build_not_found(exception.model), ErrorSerializer) }
    end

    render json: response, status: :not_found
  end

  def handle_invalid_current_password(exception)
    response = Panko::Response.create do |r|
      { error: r.serializer(ErrorMessage.build_invalid_current_password(exception), ErrorSerializer) }
    end

    render json: response, status: :unprocessable_entity
  end

  def handle_no_match_password(exception)
    response = Panko::Response.create do |r|
      { error: r.serializer(ErrorMessage.build_no_match_password(exception), ErrorSerializer) }
    end

    render json: response, status: :unprocessable_entity
  end
end
