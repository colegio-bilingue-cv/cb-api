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

  def destroy 
    student = Student.find(params[:student_id])
    student.discounts.destroy(params[:id])

    head :no_content, status: :deleted
  end

  private

  def discount_params
    params.permit(:percentage, :explanation, :start_date, :end_date, :resolution_description, :administrative_type, :resolution, :administrative_info)
  end
end
