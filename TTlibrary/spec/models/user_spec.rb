require "spec_helper"
require "rails_helper"

describe User do
  #Validations
  it "has a valid factory" do
    build(:user).should be_valid
  end

  it "is invalid without a email" do
    build(:user, email: nil).should_not be_valid
  end
  
  it "is invalid without a password" do
    build(:user, password: nil).should_not be_valid
  end
  
end
