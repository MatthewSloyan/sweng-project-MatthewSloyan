module SessionsHelper

  # Helper method that returns user logged in username.
  def get_logged_in_user

    # If found in session return username, or else nil
    if session[:user_id]
      @logged_in_user = User.find(session[:user_id]).username
    else 
      nil
    end
  end
end
