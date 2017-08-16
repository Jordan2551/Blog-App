class ArticlesController < ApplicationController
  before_action :set_article, only:[:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    redirect_to articles_list_path if logged_in?
  end

  def show
  end

  def new
    require_user
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = User.last.id
    if @article.save
      flash[:notify] = 'Article was successfully created!'
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:notify] = 'Article was successfully updated!'
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def list
    #Use the will_paginate gem to display a limited amount of articles per page to reduce
    #The load off of the server. Here we specify the page we wish to pagine, along with the amount of items per page
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def require_same_user
    if current_user != @article.user
      flash[:danger] = 'You can only edit or delete your own article'
      redirect_to root_path
    end
  end

  def article_params
    params.require(:article).permit(:title, :content, :num, :category_id)
  end
end