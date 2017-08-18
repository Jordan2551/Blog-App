class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

#All methods inside of ApplicationController are available to all controllers because
#Every controller < ApplicationController
#This is also the reason these user helpers are not located in users_controller. Because we want these methods to be accessible everywhere!

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
    !!current_user #In this case, if the user is nil, then we return false; otherwise true
  end

#Requires a user to be logged in to perform a special action
  def require_user
    if !logged_in?
      flash[:danger] = 'You must be logged in to perform that action!'
      redirect_to root_path
    end
  end

  def require_admin
    if logged_in? && !current_user.is_admin
      flash[:danger] = 'No permission to delete users.'
      redirect_to root_path
    end
  end
#Not neeeded right now
# def get_user_role
#   if logged_in?
#     case current_user.role
#       when Roles::ADMIN
#         Roles::ADMIN
#       when Roles::DEVELOPER
#         Roles::DEVELOPER
#       when Roles::BLOGGER
#         Roles::BLOGGER
#     end
#   end

#for just performing a quick login within the system (example: after creating a user)
  def quicklogin(id)
    session[:user_id] = id
  end

end