require 'rails_helper'

# Tests below coded and adapted initially from lecture videos supplied, and my implementation of CA5.
describe LoginController, type: 'controller' do

  # == SETUP ==
  # Helper method to create a new user, can be used in multiple tests.
  let(:create_user) { 
      post :create, user: { name: 'Matthew', username: 'Test_1234', email: 'test@gmail.com', password: 'test1234', password_confirmation: 'test1234'
    }
  }

  let(:login_user) { 
      post :create, user: { name: 'Matthew', username: 'Test_1234', email: 'test@gmail.com', password: 'test1234', password_confirmation: 'test1234'
    }
  }

  # == CREATE == 
  describe "#create" do
    context "When a users logins using their account details" do

      it "should reload home page and display success message if login successful" do
        # Create post request to create a user to login with.
        create_user

        # Login

        # Expect to reload home page.
        expect(@respose).to redirect_to(:recipes)

        # Expect to display flash message for user.
        # Code adated from: https://stackoverflow.com/questions/24919976/rspec-3-how-to-test-flash-messages
        expect(flash[:notice]).to eq("Test_1234 was successfully logged in.")
      end

      it "should reload login page and display error message if login unsuccessful" do
        # Create post request to create a user to try and login with.
        create_user

        # Login failed

        # Expect to reload home page.
        expect(@respose).to render_template('login/new')

        # Expect to display flash message for user.
        expect(flash[:notice]).to eq("An error occured, please read error messages below and try again.")
      end
    end
  end

  # == DESTROY/DELETE == 
  describe "#delete" do
    context "When a user logs out" do

      it "should return to home page and display success message" do
        # Create post request to create a user to login with.
        create_user

        # Login

        # Log out
        # Delete new recipe created above, by calling destroy method.
        #delete :destroy, :id => '1'

        # Expect to reload home page.
        expect(@respose).to redirect_to(:recipes)

        # Expect to display flash message for movie.
        expect(flash[:notice]).to eq("Test_1234 was successfully logged out.")
      end
    end
  end
end