class UsersController < ApplicationController
  before_action :authenticate_user!#, :authorize_role

  def index
    @roles = Role.all
    users = User.include_user_roles
    #    @users = (params[:search] ?
    #        users.search(params[:search], include: [:roles], star: true) :
    #        users).paginate(page: params[:page], per_page: 10)
    @users = users.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      #format.xls { send_data @users.to_xls, content_type: 'application/vnd.ms-excel', filename: 'users.xls' }
    end
  end

#  def update
#    @user = User.find(params[:id])
#    #raise params[:user].inspect
#    successfully_updated = if !params[:user][:password].blank?
#      @user.update_attributes!(user_params)
#    else
#      @user.update_without_password(user_params)
#    end
#    respond_to do |format|
#      if successfully_updated
#        format.html { redirect_to users_path, notice: "User was successfully updated."}
#        format.json { head :no_content }
#      else
#        format.html { render "edit" }
#        format.json { render json: @user.errors, status: :unprocessable_entity }
#      end
#    end
#  end

  def status
    user = User.find(params[:id])
    user.update_attribute('active', !user.active)
    render nothing: true
  end

  def roles
    #raise params.inspect
    user = User.find(params[:id])
    user.roles.each do |role|
      role.destroy
    end
    #params[:user][:role_ids].each do |role_id|
      user.roles.create(params[:user]) #unless role_id == ""
    #end
    respond_to do |format|
        format.html { redirect_to users_path, notice: "User was successfully updated."}
        format.json { head :no_content }
     end
  end


  # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:login, :user_name,:current_password, :email, :password, :remember_me, :role_ids)
    end
  
end
