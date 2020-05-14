class SessionsController < ApplicationController

  # Loads login page.
  def new
  end

  # Check if username/email, or password is correct.
  # If user is authenicated sign user in and display sucess message.
  # Else display error message.
  # Code adapted from http://railscasts.com/episodes/250-authentication-from-scratch
  def create
    user = User.authenticate(params[:email_username], params[:password])
    if user
      sign_in(user)

      redirect_to recipes_path
      flash[:success] = "#{user.username} was successfully logged in."
    else
      flash[:notice] = "Username, email or password is incorrect please try again."
      render "new"
    end
  end

  # Log user out by removing session data.
  def destroy
    session[:user_id] = nil

    redirect_to recipes_path
    flash[:success] = "You were successfully logged out."
  end

  # Signs user in by setting session data.
  def sign_in (user)
    session[:user_id] = user.id
  end
end
