require 'spec_helper'

describe BlitzBulletins::Topics do
  context "When loading from a file that contains 2 topics" do
    before(:each) do
      topics = ["Jan  1 04:02 topic-one", "Jan  2 04:02 topic-two"]
      @topics = BlitzBulletins::Topics.new(topics)
    end

    describe "#list" do
      it "contains the first topic" do
        @topics.list[0].name.should == 'topic-one'
      end

      it "contains the second topic" do
        @topics.list[1].name.should == 'topic-two'
      end
    end
  end
end
