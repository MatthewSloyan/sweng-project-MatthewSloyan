require 'rails_helper'

# Tests below coded and adapted initially from lecture videos supplied, and my implementation of CA5.
describe SessionsController, type: 'controller' do

  # == SETUP ==
  # Helper method to create a new user, can be used in multiple tests.
  let(:create_user) { 
    User.create!(name: 'Matthew', username: 'Test_1234', email: 'test@gmail.com', password: 'test1234', password_confirmation: 'test1234')
  }

  # == CREATE == 
  describe "#create" do
    context "When a users logs in using their email and password" do

      it "should reload home page and display success message if login successful" do
        # Create user to try and log in with (Helper method).
        create_user

        # Call post method to try to log user in.
        post :create, { email_username: 'test@gmail.com', password: 'test1234'}

        # Expect to reload home page.
        expect(@response).to redirect_to(:recipes)

        # Expect to display flash message for user.
        # Code adated from: https://stackoverflow.com/questions/24919976/rspec-3-how-to-test-flash-messages
        expect(flash[:success]).to eq("Test_1234 was successfully logged in.")
      end

      it "should reload login page and display error message if login unsuccessful" do
        # Create user to try and log in with (Helper method).
        create_user

        # Call post method to try to log user in.
        post :create, { email_username: 'fake@gmail.com', password: 'test'}

        # Expect to reload home page.
        expect(@respose).to render_template('sessions/new')
        expect(@response).to have_http_status(:success)

        # Expect to display flash message for user.
        expect(flash[:notice]).to eq("Username, email or password is incorrect please try again.")
      end
    end

    context "When a users logs in using their username and password" do

      it "should reload home page and display success message if login successful" do
        # Create user to try and log in with (Helper method).
        create_user

        # Call post method to try to log user in.
        post :create, { email_username: 'Test_1234', password: 'test1234'}

        # Expect to reload home page.
        expect(@response).to redirect_to(:recipes)

        # Expect to display flash message for user.
        # Code adated from: https://stackoverflow.com/questions/24919976/rspec-3-how-to-test-flash-messages
        expect(flash[:success]).to eq("Test_1234 was successfully logged in.")
      end

      it "should reload login page and display error message if login unsuccessful" do
        # Create user to try and log in with (Helper method).
        create_user

        # Call post method to try to log user in.
        post :create, { email_username: 'Fake_username', password: 'test'}

        # Expect to reload home page.
        expect(@respose).to render_template('sessions/new')
        expect(@response).to have_http_status(:success)

        # Expect to display flash message for user.
        expect(flash[:notice]).to eq("Username, email or password is incorrect please try again.")
      end
    end
  end

  # == DESTROY/DELETE == 
  describe "#delete" do
    context "When a user logs out" do

      it "should return to home page and display success message" do
        # Create post request to create a user to login with.
        create_user

        # Call post method to log in user
        post :create, { email_username: 'test@gmail.com', password: 'test1234'}

        # Log out by calling destroy method.
        delete :destroy, :id => '1'

        # Expect to reload home page.
        expect(@respose).to redirect_to(:recipes)

        # Expect to display flash message for movie.
        expect(flash[:success]).to eq("You were successfully logged out.")
      end
    end
  end
end