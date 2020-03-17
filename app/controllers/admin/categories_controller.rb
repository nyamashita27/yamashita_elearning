class Admin::CategoriesController < ApplicationController

  before_action :logged_in_user
  before_action :admin_user
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 10)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Created new category!" #successはbootstrapの色、青
      redirect_to admin_categories_path
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = "Successfully updated the category!"
      redirect_to admin_categories_url
    else
      render 'edit'
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_url
  end

  private
    def category_params
      params.require(:category).permit(:title, :description)
    end

end
