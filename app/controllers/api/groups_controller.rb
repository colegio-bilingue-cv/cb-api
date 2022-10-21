class Api::GroupsController < ApplicationController
  def index
    groups = Group.all

    response = Panko::Response.new(
      groups: Panko::ArraySerializer.new(groups, each_serializer: GroupSerializer)
    )

    render json: response, status: :ok
  end
  
  def create
    group = Group.create!(group_params)
    
    response = Panko::Response.create do |r|
      { group: r.serializer(group, GroupSerializer) }
    end
    
    render json: response, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: {message: e}, status: :unprocessable_entity
  end

  def update
    group = Group.find(params[:id])
    group.update!(group_params)

    response = Panko::Response.create do |r|
      { group: r.serializer(group, GroupSerializer) }
    end

    render json: response, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json:  {message: e}, status: :not_found
  rescue ActiveRecord::RecordInvalid
    render json:  {message: e}, status: :unprocessable_entity
  end

  private
  def group_params
    params.require(:group).permit(:name, :year, :grade_id, :group_id)
  end
end
