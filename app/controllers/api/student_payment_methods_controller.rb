class Api::StudentPaymentMethodsController < Api::BaseController
  def create
    raise ActiveRecord::RecordInvalid unless Student.exists?(student_payment_method_params[:student_id])
    raise ActiveRecord::RecordInvalid unless PaymentMethod.exists?(student_payment_method_params[:payment_method_id])

    student_payment_method = StudentPaymentMethod.create!(student_payment_method_params)

    response = Panko::Response.create do |r|
      { student_payment_method: r.serializer(student_payment_method, StudentPaymentMethodSerializer) }
    end

    render json: response, status: :created
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
  rescue ActiveRecord::RecordInvalid
    render json: {}, status: :unprocessable_entity
  end

  def student_payment_method_params
    params.require(:student_payment_method).permit(:year, :payment_method_id, :student_id)
  end
end
