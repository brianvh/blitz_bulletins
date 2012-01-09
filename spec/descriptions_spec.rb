require 'spec_helper'

describe BlitzBulletins::Descriptions do
  context "When loading a file that contains 2 topic descriptions" do
    before(:each) do
      @topic1 = {:name => 'topic-one', :description => 'Topic One'}
      @topic2 = {:name => 'topic-two', :description => 'Topic Two'}
      descriptions = ["#{@topic1[:name]}:#{@topic1[:description]}", "#{@topic2[:name]}:#{@topic2[:description]}"]
      @descriptions = BlitzBulletins::Descriptions.new(descriptions)
    end

    describe "#hash" do
      it "contains 2 entries" do
        @descriptions.hash.should have(2).items
      end

      it "contains topic1" do
        @descriptions.hash[@topic1[:name]].should == @topic1[:description]
      end

      it "contains topic2" do
        @descriptions.hash[@topic2[:name]].should == @topic2[:description]
      end
    end
  end
end
