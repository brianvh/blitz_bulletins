require 'spec_helper'

describe BlitzBulletins::Poster do
  before(:each) do
    @poster = BlitzBulletins::Poster.new(123)
  end

  context "When the uid is not found" do
    before(:each) do
      @poster.should_receive(:lookup).once.and_return(nil)
    end

    it "is expired" do
      @poster.should be_expired
    end

    it "has a nil name" do
      @poster.name.should be_nil
    end
  end

  context "When the uid is for an expired DND entry" do
    before(:each) do
      @profile = mock_profile("Joe DND", "1-Jan-2011")
      @poster.should_receive(:lookup).once.and_return(@profile)
    end

    it "is expired" do
      @poster.should be_expired
    end

    it "has the correct name" do
      @poster.name.should == @profile.name
    end
  end

  context "When the uid is for an active DND entry" do
    before(:each) do
      @profile = mock_profile("Joe DND", (Date.today + 1).to_s)
      @poster.should_receive(:lookup).once.and_return(@profile)
    end

    it "is not expired" do
      @poster.should_not be_expired
    end
  end

  context "When the uid is for a DND entry with no expires" do
    before(:each) do
      @profile = mock_profile("Joe DND", "")
      @poster.should_receive(:lookup).once.and_return(@profile)
    end

    it "is not expired" do
      @poster.should_not be_expired
    end
  end
end
