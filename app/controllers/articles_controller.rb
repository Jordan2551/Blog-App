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
    @articles = Article.all
  end
 
  private
    def article_params
      params.require(:article).permit(:title, :content, :num)
    end
end