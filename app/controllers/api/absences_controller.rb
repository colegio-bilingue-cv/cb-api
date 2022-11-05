class Api::AbsencesController < Api::BaseController
    def create
      user = User.find(params[current_user.id])
      absence = user.absences.create!(absence_params)
  
      response = Panko::Response.create do |r|
        { absence: r.serializer(absence, AbsenceSerializer) }
      end
  
      render json: response, status: :created
    end
  
    private
  
    def absence_params
      params.permit(:start_date, :end_date, :reason, :certificate)
    end
end
  