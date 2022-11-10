class Api::StudentPaymentMethodsController < Api::BaseController
  def create
    raise ActiveRecord::RecordNotFound.new('', Student.to_s) unless Student.exists?(student_payment_method_params[:student_id])
    raise ActiveRecord::RecordNotFound.new('', PaymentMethod.to_s) unless PaymentMethod.exists?(student_payment_method_params[:payment_method_id])

    student_payment_method = StudentPaymentMethod.create!(student_payment_method_params)

    response = Panko::Response.create do |r|
      { student_payment_method: r.serializer(student_payment_method, StudentPaymentMethodSerializer) }
    end

    render json: response, status: :created
  end

  def update
    raise ActiveRecord::RecordNotFound.new('', Student.to_s) unless Student.exists?(student_payment_method_params[:student_id])
    raise ActiveRecord::RecordNotFound.new('', PaymentMethod.to_s) unless PaymentMethod.exists?(student_payment_method_params[:payment_method_id])

    student_payment_method = StudentPaymentMethod.find(params[:id])
    student_payment_method.update!(student_payment_method_params)

    response = Panko::Response.create do |r|
      { student_payment_method: r.serializer(student_payment_method, StudentPaymentMethodSerializer) }
    end

    render json: response, status: :ok
  end

  private
  def student_payment_method_params
    params.permit(:year, :payment_method_id, :student_id, :annual_payment)
  end
end
