class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #All methods inside of ApplicationController are available to all controllers because
  #Every controller < ApplicationController

  #These methods will be available to our views
  helper_method :current_user, :logged_in?

  #Attempt to find the User enrolled in the session from the db
  def current_user
    if session[:user_id]
      #This line makes use of Memoization.
      #Definition: Memoization is the process of storing
      #a computed value to avoid duplicated work by future calls.
      #see: http://gavinmiller.io/2013/basics-of-ruby-memoization/
      @current_user ||= User.find(session[:user_id])
    end
  end

  #!! casts a variable into type boolean and determine its truthy or falsy value
  def logged_in?
    !!current_user#In this case, if the user is nil, then we return false; otherwise true
  end

  def require_user
    if logged_in?
      flash[:danger] = "You must be logged in to perform that action!"
      redirect_to root_path
    end
  end

end
