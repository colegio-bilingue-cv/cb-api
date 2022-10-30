class Api::DiscountsController < Api::BaseController
  def create
    student = Student.find(params[:student_id])
    discount = student.discounts.create!(discount_params)

    response = Panko::Response.create do |r|
      { discount: r.serializer(discount, DiscountSerializer) }
    end

    render json: response, status: :created
  end

  def update
    student = Student.find(params[:student_id])
    discount = student.discounts.find(params[:id])
    discount.update!(discount_params)

    response = Panko::Response.create do |r|
      { discount: r.serializer(discount, DiscountSerializer) }
    end

    render json: response, status: :created
  end

  private

  def discount_params
    params.require(:discount).permit(:percentage, :explanation, :start_date, :end_date, :resolution_description, :administrative_type, :resolution, :administrative_info)
  end
end
