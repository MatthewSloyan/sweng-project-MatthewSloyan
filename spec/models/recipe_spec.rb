require 'rails_helper'

describe "#ratings" do
  it "should return all difficulties" do
    # Check for word array of difficulties
    expect(Recipe.all_difficulties).to eq(["Easy", "Medium", "Hard"])
  end
end
