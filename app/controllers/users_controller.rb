class UsersController < ApplicationController

  # Validates creation of user request so that the data meets the requirments.
  # Full validation is completed in User model before save.
  def user_params
    params.require(:user).permit(:username, :name, :email, :password, :password_confirmation)
  end

  def new
    # Create a new User
    @user = User.new
  end

  def create
    # Create a new user and save to database.
    @user = User.new(user_params)

    if @user.save
        flash[:notice] = "An account for #{@user.username} was successfully created. Please login."
        redirect_to recipes_path
    else
        flash[:notice] = "An error occured, please read error messages below and try again."
        render "new"
    end
  end
end
