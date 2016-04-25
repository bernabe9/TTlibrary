require "spec_helper"
require "rails_helper"

describe Book do
  #Validations
  it "has a valid factory" do
    build(:book).should be_valid
  end

  it "is invalid without a title" do
    build(:book, title: nil).should_not be_valid
  end
  
  it "is invalid without a year" do
    build(:book, year: nil).should_not be_valid
  end

  it "is invalid without a ISBN" do
    build(:book, ISBN: nil).should_not be_valid
  end

  it "is invalid without a author_id" do
    build(:book, author_id: nil).should_not be_valid
  end
  
end
