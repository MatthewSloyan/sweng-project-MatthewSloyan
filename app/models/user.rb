class User < ActiveRecord::Base
  # The code below is used to validate a new user and create and hash their credentials.
  # Note: Code is heavily adapted from: http://railscasts.com/episodes/250-authentication-from-scratch
  
  # attr_accessor Creates a get and set for password.
  attr_accessor :password

  # Before writing to the database, 
  # Code adapted from: https://stackoverflow.com/questions/23860329/understanding-before-save-in-ruby-rails
  before_save :encrypt_user_password
  
  # Checks if confirmation password matches.
  validates_confirmation_of :password
  
  # Check if password, email and username exist.
  # Also checks if email and username are unique in the database (If an account already exists).
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_presence_of :username
  validates_uniqueness_of :email
  validates_uniqueness_of :username
  
  def self.authenticate(email, password)
    user = find_by_email(email)

    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  # Using bycrypt create a salt, and hash user password with salt.
  # bycrypt docs: https://github.com/codahale/bcrypt-ruby
  def encrypt_user_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
