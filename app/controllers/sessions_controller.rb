class SessionsController < ApplicationController

  def new
    
  end

  def create
    @user = User.authenticate_by(email: params[:email], password: params[:password])
    if @user.blank?
      redirect_to login_path, alert: 'Invalid credentials'
      return
    end

    session[:user_id] = @user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

end
