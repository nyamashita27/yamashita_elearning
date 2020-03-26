class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @activities = Activity.where("user_id IN (?) OR user_id = ?", current_user.followed_users.ids, current_user.id).paginate(page: params[:page], per_page: 10).order(updated_at: :desc)
      render "users/home_feed"
    end
  end

  def about
  end
end
