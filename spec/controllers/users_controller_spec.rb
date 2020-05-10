require 'rails_helper'

# Tests below coded and adapted initially from lecture videos supplied, and my implementation of CA5.
describe UsersController, type: 'controller' do

  # == SETUP ==
  # Helper method to create a new user, can be used in multiple tests.
  let(:create_user) { 
      post :create, user: { name: 'Matthew', username: 'Test_1234', email: 'test@gmail.com', password: 'test1234', password_confirmation: 'test1234'
    }
  }

  let(:create_user_error) { 
      post :create, user: { name: 'Matthew', username: '', email: '', password: 'test1234'
    }
  }

  # == CREATE == 
  describe "#create" do
    context "When a users creates a new account" do

      it "should create a new user" do
        # Expect post request created to change recipe count by one (add recipe)
        # Code adapted from: https://stackoverflow.com/questions/50630315/rspec-count-change-by
        expect { create_user }.to change { User.count }.by(1)
      end

      it "should reload home page and display success message if sign up successful" do
        # Create post request.
        create_user

        # Expect to reload home page.
        expect(@respose).to redirect_to(:recipes)

        # Expect to display flash message for user.
        # Code adated from: https://stackoverflow.com/questions/24919976/rspec-3-how-to-test-flash-messages
        expect(flash[:notice]).to eq("An account for Test_1234 was successfully created. Please login.")
      end

      it "should reload new user and display error message if sign up unsuccessful" do
        # Create post request that will cause an error.
        create_user_error

        # Expect to reload home page.
        expect(@respose).to render_template('users/new')

        # Expect to display flash message for user.
        expect(flash[:notice]).to eq("An error occured, please read error messages below and try again.")
      end
    end
  end
end