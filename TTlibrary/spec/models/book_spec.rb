require "spec_helper"
require "rails_helper"

describe Book do
  #Validations
  it "has a valid factory" do
    expect(build(:book)).to be_valid
  end

  it "is invalid without a title" do
    expect(build(:book, title: nil)).to_not be_valid
  end
  
  it "is invalid without a year" do
    expect(build(:book, year: nil)).to_not be_valid
  end

  it "is invalid without a ISBN" do
    expect(build(:book, ISBN: nil)).to_not be_valid
  end

  it "is invalid without a author_id" do
    expect(build(:book, author_id: nil)).to_not be_valid
  end
  
end
