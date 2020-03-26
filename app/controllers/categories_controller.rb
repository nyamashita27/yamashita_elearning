class CategoriesController < ApplicationController

  before_action :logged_in_user

  def index
    @categories = Category.paginate(page: params[:page], per_page: 10).order(updated_at: :desc)
    @status = params[:status]

    if @status == "1"
      @categories = current_user.categories.paginate(page: params[:page], per_page: 10).order(updated_at: :desc)
    elsif @status =="0"
      @categories = @categories.where.not(id: current_user.category_ids).paginate(page: params[:page], per_page: 10).order(updated_at: :desc)
    end
  end

end
