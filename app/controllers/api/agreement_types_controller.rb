class Api::AgreementTypesController < Api::BaseController
    def index
        agreement_types = AgreementType.all
        
        response = Panko::Response.new(
          agreement_types: Panko::ArraySerializer.new(agreement_types, each_serializer: AgreementTypeSerializer)
        )
        render json: response, status: :ok
    end
    
    def show
      agreement_type = AgreementType.find(params[:id])
  
      response = Panko::Response.create do |r|
        { agreement_type: r.serializer(agreement_type, AgreementTypeSerializer) }
      end
  
      render json: response, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: :not_found
    end

    def create
        agreement_type = AgreementType.create!(agreement_type_params)
    
        response = Panko::Response.create do |r|
          { agreement_type: r.serializer(agreement_type, AgreementTypeSerializer) }
        end
    
        render json: response, status: :created
      rescue ActiveRecord::RecordInvalid
        render json: {}, status: :unprocessable_entity
      end
    end
    
    def destroy
        agreement_type = AgreementType.find(params[:id])
        agreement_type.destroy!()

        response = Panko::Response.create do |r|
            { agreement_type: r.serializer(agreement_type, AgreementTypeSerializer) }
        end
  
    def update
      agreement_type = AgreementType.find(params[:id])
      agreement_type.update!(agreement_type_params)
      
      response = Panko::Response.create do |r|
        { agreement_type: r.serializer(agreement_type, AgreementTypeSerializer) }
      end
      
      render json: response, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: :not_found
    rescue ActiveRecord::RecordInvalid
      render json: {}, status: :unprocessable_entity
    end

    private
    
    def agreement_type_params
      params.require(:agreement_type).permit(:description
      )
    end
end
