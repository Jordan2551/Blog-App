class SessionsController < ApplicationController

  #Renders a login form
  def new
  end

  #Starts a sessions (successfully logs in)
  #QUESTION: why are we using email: params[:session][:email] and not params[:email] like before?
  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      #Save user id in session so that we create a session. The user id stored in this hash will be used for requests.
      session[:user_id] = @user.id
      flash[:success] = "You have successfully logged in"
      redirect_to users_path(@user)
    else
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new'
    end
  end

  #Destroys a session (logs out)
  def destroy
    #Set the session's user_id to nil, basically destroying the session
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end

end