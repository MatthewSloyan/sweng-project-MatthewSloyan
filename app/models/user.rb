class User < ActiveRecord::Base
  # The code below is used to validate a new user and create and hash their credentials.
  # Note: All code is heavily adapted from: http://railscasts.com/episodes/250-authentication-from-scratch
  
  # attr_accessor Creates a get and set for password.
  attr_accessor :password

  # Before writing to the database encrypt password using bycrypt.
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
  
  # Authenticate user by first finding user by email or username.
  # Then check password against hash and salt.
  def self.authenticate(email_username, password)

    # Find user by email, and check if password matches.
    if user = find_by_email(email_username)
      if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        user
      end

    # Find user by username, and check if password matches.
    elsif user = find_by_username(email_username)
      if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        user
      end

    # User not found or password is invalid.
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
