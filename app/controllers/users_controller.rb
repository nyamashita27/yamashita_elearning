class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :only_loggedin_users, only: [:index, :edit, :update]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to E-Learning page!" #successはbootstrapの色、青
      redirect_to root_url 
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Successfully updated your information!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @activities = @user.activities.paginate(page: params[:page], per_page: 10).order(updated_at: :desc)
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user == @user
    end
end
