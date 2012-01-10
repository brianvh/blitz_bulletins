require 'spec_helper'

describe BlitzBulletins::Posters do

  context "When loading a file with 2 posters for topic-one and a duplicate poster for topic-two" do
    let(:poster_1) { poster_line('50843', 'topic-one') }
    let(:poster_2) { poster_line('57794', 'topic-two') }
    let(:poster_3) { poster_line('57794', 'topic-one') }
    let(:posters) { [poster_1.line, poster_2.line, poster_3.line] }

    before do
      @posters = BlitzBulletins::Posters.new
      @posters.should_receive(:get_poster).twice.and_return(mock(:poster1), mock(:poster2))
      @posters.parse(posters)
    end

    describe "#hash" do
      subject { @posters.hash }

      it { should have(2).items }
      it { should have_key(poster_1.uid) }
      it { should have_key(poster_2.uid) }

    end

    describe "#in_topic" do
      it "contains 2 posters for topic-one" do
        @posters.in_topic[poster_1.topic].should have(2).items
      end

      it "contains 1 poster for topic-two" do
        @posters.in_topic[poster_2.topic].should have(1).items
      end
    end
  end
end
