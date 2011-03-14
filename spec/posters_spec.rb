require 'spec_helper'

describe BlitzBulletins::Posters do
  context "When loading a file with 2 posters for topic-one and a duplicate poster for topic-two" do
    before(:each) do
      @poster1 = poster_line('50843', 'topic-one')
      @poster2 = poster_line('57794', 'topic-two')
      @poster3 = poster_line('57794', 'topic-one')
      posters = [@poster1.line, @poster2.line, @poster3.line]
      @posters = BlitzBulletins::Posters.new
      @posters.should_receive(:readlines).once.and_return(posters)
      @posters.should_receive(:get_poster).twice.and_return(mock(:poster1), mock(:poster2))
      @posters.parse_file
    end

    describe "#hash" do
      it "contains only 2 entries" do
        @posters.hash.should have(2).items
      end

      it "contains poster1's uid" do
        @posters.hash.should have_key(@poster1.uid)
      end

      it "contains poster2's uid" do
        @posters.hash.should have_key(@poster2.uid)
      end
    end

    describe "#in_topic" do
      it "contains 2 posters for topic-one" do
        @posters.in_topic[@poster1.topic].should have(2).items
      end

      it "contains 1 poster for topic-two" do
        @posters.in_topic[@poster2.topic].should have(1).items
      end
    end
  end
end
