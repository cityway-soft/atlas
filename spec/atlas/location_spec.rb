require 'spec_helper'
include Atlas

describe Location do

  before(:each) do
    @location = Location.new :name => "dummy"
    @zone = mock(Zone)
  end

  it "should use the reference hash if not an ActiveRecord" do
    Location.from("dummy").uid.should == "dummy".hash
  end

  it "should use the given name" do
    Location.from("dummy", :name => "given name").name.should == "given name"
  end

  it "should use the given reference" do
    Location.from("dummy", :reference => "given reference").reference.should == "given reference"
  end

  it "should the reference name if available" do
    reference = mock("reference", :name => "reference name")
    Location.from(reference).name.should == "reference name"
  end

  it "should transform the name into words if none given" do
    Location.from("name").words.should == "name".to_words
  end

  describe "references" do

    before(:each) do
      @locations = Array.new(3) do |n| 
        mock(Location, :reference => "reference-#{n}") 
      end
      @references = @locations.collect(&:reference)
    end
    
    it "should return references associated to locations" do
      Location.references(@locations).should == @references
    end

    it "should return references in the same order than locations" do
      Location.references(@locations).should == @references
    end

  end

end
