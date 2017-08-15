class ArticlesController < ApplicationController
  
  def index
  end
 
  def show
    @article = Article.find(params[:id])
  end
 
  def new
    @article = Article.new
  end
 
  def edit
    @article = Article.find(params[:id])
  end
 
  def create
    @article = Article.new(article_params)
    @article.user_id = User.last.id
    if @article.save
      flash[:notify] = "Article was successfully created!"
      redirect_to @article
    else
      render 'new'
    end
  end
 
  def update
    @article = Article.find(params[:id])
 
    if @article.update(article_params)
      flash[:notify] = "Article was successfully updated!"
      redirect_to @article
    else
      render 'edit'
    end
  end
 
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
  
    redirect_to articles_path
  end
 
  def list
    #Use the will_paginate gem to display a limited amount of articles per page to reduce
    #The load off of the server. Here we specify the page we wish to pagine, along with the amount of items per page
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end
 
  private
    def article_params
      params.require(:article).permit(:title, :content, :num)
    end
end