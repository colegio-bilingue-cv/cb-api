class Api::TeachersController < Api::BaseController
  def index
    teachers = User.by_role_id(2)

    
  end
end

