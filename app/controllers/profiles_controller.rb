class ProfilesController < ApplicationController
  before_action  :require_login
  def show

  end

  def update
     if(user_params.permitted?)
       if(current_user.update(user_params))
         render status: 200, action: "show" and return
       end
     end
     render status: :unprocessable_entity, action: "show"
  end

  private
  def user_params
    params.require(Clearance.configuration.user_parameter).permit(:first_name, :last_name, :email, :password)
  end
end
