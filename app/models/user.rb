class User < ActiveRecord::Base
  # The code below is used to validate a new user and create and hash their credentials.
  # Note: Code is heavily adapted from: http://railscasts.com/episodes/250-authentication-from-scratch
  
  # attr_accessor Creates a get and set for password.
  attr_accessor :password
  
  # Checks if confirmation password matches.
  validates_confirmation_of :password
  
  # Check if password, email and username exist.
  # Also checks if email and username are unique in the database (If an account already exists).
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_presence_of :username
  validates_uniqueness_of :email
  validates_uniqueness_of :username
end
