require 'rails_helper'

# Specs in this file have access to a helper object that includes the SessionsHelper.
describe SessionsHelper do
  describe "get_logged_in_user" do
    it "gets the username of the logged in user" do

      # Fake login by creating a user and setting session variable.
      User.create!(name: 'Matthew', username: 'Test_User', email: 'test@gmail.com', password: 'test1234', password_confirmation: 'test1234')
      @request.session['user_id'] = 1

      expect(get_logged_in_user).to eq("Test_User")
    end
  end
end