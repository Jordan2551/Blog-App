class CategoriesController < ApplicationController
  before_action :require_user, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]


  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category created"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end