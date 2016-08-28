require "spec_helper"
require "rails_helper"

describe Comment do
  #Validations
  it "has a valid factory" do
    expect(build(:comment)).to be_valid
  end

  it "is invalid without a text" do
    expect(build(:comment, text: nil)).to_not be_valid
  end
  
end
