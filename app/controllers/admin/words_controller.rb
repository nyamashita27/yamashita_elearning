class Admin::WordsController < ApplicationController

  before_action :logged_in_user
  before_action :admin_user

  def index
    @category = Category.find(params[:category_id])
    @words = @category.words.paginate(page: params[:page], per_page: 10).order(updated_at: :desc)
  end

  def new
    @category = Category.find(params[:category_id])
    @word = @category.words.build #buildは関係性作るのに必要
    # @word = Word.new <-categoryとの関係性作らなくてよければ、これだけでいい
    3.times {@word.choices.build}
  end

  def create
    @category = Category.find(params[:category_id])
    @word = @category.words.build(word_params)
    if @word.save
      flash[:success] = "Successfully Created Word!"
      redirect_to admin_category_words_url
    else
      render 'new'
    end
  end

  private
    def word_params
      params.require(:word).permit(:content, choices_attributes: [:id, :content, :correct])
    end

end
