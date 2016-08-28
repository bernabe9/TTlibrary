require "spec_helper"
require "rails_helper"

describe Author do
  #Validations
  it "has a valid factory" do
    expect(build(:author)).to be_valid
  end

  it "is invalid without a firstname" do
    expect(build(:author, first_name: nil)).to_not be_valid
  end
  
  it "is invalid without a lastname" do
    expect(build(:author, last_name: nil)).to_not be_valid
  end
  
end
