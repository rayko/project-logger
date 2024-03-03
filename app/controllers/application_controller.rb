class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :authorize_user!, only: [:index]
  
  def index
  end

  private

  def current_user
    @current_user ||= session[:user_id] && User.where(id: session[:user_id]).take
  end

  def authorize_user!
    unless current_user
      redirect_to login_path, alert: 'You need to login'
    end
  end
  
end
