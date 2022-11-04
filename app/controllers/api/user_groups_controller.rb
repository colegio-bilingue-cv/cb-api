class Api::UserGroupsController < Api::BaseController
  def create
    raise ActiveRecord::RecordNotFound.new('', User.to_s) unless User.exists?(params[:user_id])
    raise ActiveRecord::RecordNotFound.new('', Group.to_s) unless Group.exists?(params[:group_id])
    raise ActiveRecord::RecordNotFound.new('', Role.to_s) unless Role.exists?(name: params[:role])

    role_id = Role.find_by(name: params[:role]).id

    user_group = UserGroup.create!(user_id: params[:user_id], group_id: params[:group_id], role_id: role_id)

    response = Panko::Response.create do |r|
      { user_group: r.serializer(user_group, UserGroupSerializer) }
    end

    render json: response, status: :created
  end

  def destroy
    raise ActiveRecord::RecordNotFound.new('', User.to_s) unless User.exists?(params[:user_id])
    raise ActiveRecord::RecordNotFound.new('', Group.to_s) unless Group.exists?(params[:group_id])
    raise ActiveRecord::RecordNotFound.new('', Role.to_s) unless Role.exists?(name: params[:role])

    role_id = Role.find_by(name: params[:role]).id

    raise ActiveRecord::RecordNotFound.new('', UserGroup.to_s) unless UserGroup.exists?(user_id: params[:user_id], group_id: params[:group_id], role_id: role_id)

    role_id = Role.find_by(name: params[:role]).id

    UserGroup.where(user_id: params[:user_id], group_id: params[:group_id], role_id: role_id).delete_all

    render json: {}, status: :ok
  end
end
