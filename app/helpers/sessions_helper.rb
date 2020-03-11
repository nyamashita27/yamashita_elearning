module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
  end

  # Returns the current logged-in user (if any).
  def current_user
    User.find_by(id: session[:user_id])
  end

  def current_user?(user)
    user == current_user
  end
  
  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
  
  def only_loggedin_users
    # Goes to login page UNLESS the user is logged in already
    redirect_to login_url unless logged_in?
  end

end
