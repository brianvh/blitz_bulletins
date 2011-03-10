require 'spec_helper'

describe BlitzBulletins::Topics do
  context "When loading from a file that contains 2 topics" do
    before(:each) do
      topics = ["Jan  1 04:02 topic-one", "Jan  2 04:02 topic-two"]
      @topics = BlitzBulletins::Topics.new
      @topics.should_receive(:readlines).once.and_return(topics)
      @topic1 = mock(:one)
      @topic2 = mock(:two)
      @topics.should_receive(:topic_from_line).twice.and_return(@topic1, @topic2)
      @topics.parse_file
    end

    describe "#list" do
      it "contains the 2 topics" do
        @topics.list.should == [@topic1, @topic2]
      end
    end
  end
end
