class Api::BaseController < ApplicationController
  include Authentication

  respond_to :json

  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  rescue_from ActiveRecord::RecordNotUnique, with: :handle_record_not_unique

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

  def handle_record_not_unique(exception)
    response =  Panko::Response.create do |r|
      { error: r.serializer(ErrorMessage.build_not_unique(exception), ErrorSerializer) }
    end

    render json: response, status: :conflict
  end

end
