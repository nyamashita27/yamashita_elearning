class SessionsController < ApplicationController
  before_action :check_signed_in, only: [:new]

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "Successfully logged in!"
      redirect_to root_url
    else
      flash[:danger] = "Invalid email or password."
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

    def check_signed_in
      redirect_to(root_url) if logged_in?
    end

end
