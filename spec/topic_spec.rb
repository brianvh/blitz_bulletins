require 'spec_helper'

describe BlitzBulletins::Topic do
  before(:each) do
    @name = 'topic-one'
    @date = 'Jan  1 2010'
  end

  context "When creating a new instance" do
    context "without a supplied date" do
      before(:each) do
        @topic = BlitzBulletins::Topic.new(@name)
      end

      describe "#name" do
        it "returns the correct name" do
          @topic.name.should == @name
        end
      end

      describe "#date" do
        it "returns today as the date" do
          @topic.date.should == Date.today.to_s
        end
      end
    end

    context "with a supplied date" do
      before(:each) do
        @topic = BlitzBulletins::Topic.new(@name, Date.parse(@date))
      end

      describe "#to_s" do
        it "returns the correct output" do
          @topic.to_s.should == 'topic-one: 01/01/2010'
        end
      end
    end
  end

  context "When parsing a line from a topics file" do
    before(:each) do
      @topic = BlitzBulletins::Topic.from_line("#{@date} #{@name}")
    end

    describe "#to_s" do
      it "returns the correct output" do
        @topic.to_s.should == 'topic-one: 01/01/2010'
      end
    end
  end
end
