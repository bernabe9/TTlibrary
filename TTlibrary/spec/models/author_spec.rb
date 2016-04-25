require "spec_helper"
require "rails_helper"

describe Author do
  #Validations
  it "has a valid factory" do
    build(:author).should be_valid
  end

  it "is invalid without a firstname" do
    build(:author, first_name: nil).should_not be_valid
  end
  
  it "is invalid without a lastname" do
    build(:author, last_name: nil).should_not be_valid
  end
  
end
