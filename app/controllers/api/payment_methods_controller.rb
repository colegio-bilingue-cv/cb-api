class Api::PaymentMethodsController < Api::BaseController
  def index
    payment_method = PaymentMethod.all

    response = Panko::Response.new(
      payment_methods: Panko::ArraySerializer.new(payment_method, each_serializer: PaymentMethodSerializer)
    )

    render json: response, status: :ok
  end

  def create
    payment_method = PaymentMethod.create!(payment_method_params)

    response = Panko::Response.create do |r|
      { payment_method: r.serializer(payment_method, PaymentMethodSerializer) }
    end

      render json: response, status: :created
    rescue ActiveRecord::RecordInvalid
    render json: {}, status: :unprocessable_entity
  end

  def show
    payment_method = PaymentMethod.find(params[:id])

    response = Panko::Response.create do |r|
      { payment_method: r.serializer(payment_method, PaymentMethodSerializer) }
    end

    render json: response, status: :ok
  end

  private

  def payment_method_params
    params.require(:payment_method).permit(:method)
  end
end
