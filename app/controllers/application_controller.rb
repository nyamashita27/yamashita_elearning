class ApplicationController < ActionController::Base
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please login first"
      redirect_to login_url
    end
  end

  def admin_user
    unless current_user.admin?
      flash[:danger] = "You are not authorized..."
      redirect_to root_url
    end
  end

end
