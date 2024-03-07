class UsersController < ApplicationController
  before_action :authorize_user!
  before_action :set_user, only: %i[ show edit update update_password change_password ]

  def update_password
  end

  def change_password
    @user.old_password = params[:user][:old_password]
    @user.new_password = params[:user][:new_password]
    @user.new_password_confirmation = params[:user][:new_password_confirmation]
    if @user.update_password
      redirect_to @user, notice: 'Password updated'
    else
      render :update_password, status: :unprocessable_entity
    end
  end
  
  # GET /users/1 or /users/1.json
  def show
    if !@user.admin? && params[:id] != @user.id
      return redirect_to(root_path, alert: 'Not allowed')
    end
  end

  # GET /users/1/edit
  def edit
    if !@user.admin? && params[:id] != @user.id
      return redirect_to(root_path, alert: 'Not allowed')
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if !@user.admin? && params[:id] != @user.id
      return redirect_to(root_path, alert: 'Not allowed')
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :old_password, :new_password, :new_password_confirmation)
  end

end
