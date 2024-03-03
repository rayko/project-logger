class UsersController < ApplicationController
  before_action :authorize_user!
  before_action :set_user, only: %i[ show update ]

  # GET /users/1 or /users/1.json
  def show
    if !current_user.admin? && params[:id] != current_user.id
      return redirect_to(root_path, alert: 'Not allowed')
    end
  end

  # GET /users/1/edit
  def edit
    if !current_user.admin? && params[:id] != current_user.id
      return redirect_to(root_path, alert: 'Not allowed')
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if !current_user.admin? && params[:id] != current_user.id
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
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name)
  end

end
