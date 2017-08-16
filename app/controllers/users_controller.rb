class UsersController < ApplicationController

  before_action :find_user, only: [:show, :update, :edit]
  before_action :require_same_user, only: [:edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page], per_page: 4)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      quicklogin(@user)
      flash[:success] = "Welcome to Jordan's blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  #QUESTION: why does create always require a password while update does not?
  #ANSWER: when we update we get the desired user from the db with the password information already loaded, which means a password is actually provided (directly from the db)
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Your account has updated successfully'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html {redirect_to users_url, notice: 'User was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
  def find_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.is_admin
      flash[:danger] = 'You must log in to that account in order to edit it'
      redirect_to root_path
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
