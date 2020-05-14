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
        flash[:success] = "An account for #{@user.username} was successfully created. Please login."
        redirect_to recipes_path
    else
        flash[:notice] = "An error occured, please read error messages below and try again."
        render "new"
    end
  end

  def show
    # Get only required user information, for security reasons.
    # So that hashed passwords and emails aren't shown or accessible to all users.
    @user = User.select(:id, :name, :username).find_by(username: params[:username])

    # Sad path, if there is no user exists.
    if !@user
        flash[:notice] = "An account for #{params[:username]} does not exist."
        redirect_to recipes_path
    end

    # Display all recipes by the author selected. If there is no recipes found this is handled in the view.
    @recipes = Recipe.find_by_author(params[:username])
  end
end
