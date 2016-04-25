require "spec_helper"
require "rails_helper"

describe Comment do
  #Validations
  it "has a valid factory" do
    build(:comment).should be_valid
  end

  it "is invalid without a text" do
    build(:comment, text: nil).should_not be_valid
  end
  
end
