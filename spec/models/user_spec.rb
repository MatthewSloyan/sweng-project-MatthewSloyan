require "rails_helper"

describe "#authenticate" do

  it "should find user by email" do
    # Create a user as store as variable.
    user = User.create!(name: 'Matthew', username: 'Test_Author', email: 'test@gmail.com', password: 'test1234', password_confirmation: 'test1234')

    # Try to authenticate against created user above, and save return user.
    check_user = User.authenticate('test@gmail.com', 'test1234')

    # Check if returned user equals the user created.
    expect(check_user).to eq(user)
  end

  it "should find user by username" do
    # Create a user as store as variable.
    user = User.create!(name: 'Matthew', username: 'Test_Author', email: 'test@gmail.com', password: 'test1234', password_confirmation: 'test1234')

    # Try to authenticate against created user above, and save return user.
    check_user = User.authenticate('Test_Author', 'test1234')

    # Check if returned user equals the user created.
    expect(check_user).to eq(user)
  end

  it "should find user if email or username is right but password is wrong" do
    # Create a user as store as variable.
    user = User.create!(name: 'Matthew', username: 'Test_Author', email: 'test@gmail.com', password: 'test1234', password_confirmation: 'test1234')

    # Try to authenticate against created user above, and save return user.
    check_user = User.authenticate('test@gmail.com', 'testfail')

    # Check if returned user equals the user created.
    expect(check_user).to eq(nil)
  end

  it "should not find user" do
    # Create a user as store as variable.
    user = User.create!(name: 'Matthew', username: 'Test_Author', email: 'test@gmail.com', password: 'test1234', password_confirmation: 'test1234')

    # Try to authenticate against created user above, and save return user.
    check_user = User.authenticate('fail@gmail.com', 'testfail')

    # Check if returned user equals the user created.
    expect(check_user).to eq(nil)
  end
end
